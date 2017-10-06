//
//  TSAlertViewInput.m
//
//  Created by Nick Hodapp aka Tom Swift on 1/19/11.
//

#import "TSAlertViewInput.h"
#import <QuartzCore/QuartzCore.h>

@interface TSAlertOverlayWindow1 : UIWindow
{
}
@property (nonatomic,retain) UIWindow* oldKeyWindow1;
@end

@implementation  TSAlertOverlayWindow1
@synthesize oldKeyWindow1;

- (void) makeKeyAndVisible
{
    self.oldKeyWindow1 = [[UIApplication sharedApplication] keyWindow];
    self.windowLevel = UIWindowLevelAlert;
    [super makeKeyAndVisible];
}

- (void) resignKeyWindow
{
    [super resignKeyWindow];
    [self.oldKeyWindow1 makeKeyWindow];
}

//- (void) drawRect: (CGRect) rect
//{
//	// render the radial gradient behind the alertview
//
//	CGFloat width			= self.frame.size.width;
//	CGFloat height			= self.frame.size.height;
//	CGFloat locations[3]	= { 0.0, 0.5, 1.0 	};
//	CGFloat components[12]	= {	1, 1, 1, 0.5,
//		0, 0, 0, 0.5,
//		0, 0, 0, 0.7	};
//
//	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//	CGGradientRef backgroundGradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 3);
//	CGColorSpaceRelease(colorspace);
//
//	CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
//								backgroundGradient,
//								CGPointMake(width/2, height/2), 0,
//								CGPointMake(width/2, height/2), width,
//								0);
//
//	CGGradientRelease(backgroundGradient);
//}

- (void) dealloc
{
    self.oldKeyWindow1 = nil;
    
    NSLog( @"TSAlertViewInput: TSAlertOverlayWindow dealloc" );
    
    [super dealloc];
}

@end

@interface TSAlertViewInput (private)
@property (nonatomic, readonly) NSMutableArray* buttons;
@property (nonatomic, readonly) UILabel* titleLabel;
@property (nonatomic, readonly) UILabel* messageLabel;
@property (nonatomic, readonly) UITextView* messageTextView;
- (void) TSAlertViewInput_commonInit;
- (void) releaseWindow: (int) buttonIndex;
- (void) pulse;
- (CGSize) titleLabelSize;
- (CGSize) messageLabelSize;
- (CGSize) inputTextFieldSize;
- (CGSize) buttonsAreaSize_Stacked;
- (CGSize) buttonsAreaSize_SideBySide;
- (CGSize) recalcSizeAndLayout: (BOOL) layout;
@end

@interface TSAlertViewInputController : UIViewController
{
}
@end

@implementation TSAlertViewInputController
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    
    return;
    
    TSAlertViewInput* av = [self.view.subviews lastObject];
    if (!av || ![av isKindOfClass:[TSAlertViewInput class]])
        return;
    // resize the alertview if it wants to make use of any extra space (or needs to contract)
    [UIView animateWithDuration:duration
                     animations:^{
                         [av sizeToFit];
                         av.center = CGPointMake( CGRectGetMidX( self.view.bounds ), CGRectGetMidY( self.view.bounds ) );;
                         av.frame = CGRectIntegral( av.frame );
                     }];
}

- (void) dealloc
{
    NSLog( @"TSAlertViewInput: TSAlertViewInputController dealloc" );
    [super dealloc];
}

@end


@implementation TSAlertViewInput

@synthesize delegate;
@synthesize cancelButtonIndex;
@synthesize firstOtherButtonIndex;
@synthesize buttonLayout;
@synthesize width;
@synthesize maxHeight;
@synthesize usesMessageTextView;
@synthesize backgroundImage = _backgroundImage;
@synthesize style;

const CGFloat kTSAlertViewInput_LeftMargin	= 15.0;
const CGFloat kTSAlertViewInput_TopMargin	= 5.0;
const CGFloat kTSAlertViewInput_BottomMargin = 5.0;
const CGFloat kTSAlertViewInput_RowMargin	= 5.0;
const CGFloat kTSAlertViewInput_ColumnMargin = 10.0;

- (id) init
{
    if ( ( self = [super init] ) )
    {
        [self TSAlertViewInput_commonInit];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if ( ( self = [super initWithFrame: frame] ) )
    {
        [self TSAlertViewInput_commonInit];
        
        if ( !CGRectIsEmpty( frame ) )
        {
            width = frame.size.width;
            maxHeight = frame.size.height;
        }
    }
    return self;
}

- (id) initWithTitle: (NSString *) t message: (NSString *) m delegate: (id) d cancelButtonTitle: (NSString *) cancelButtonTitle otherButtonTitles: (NSString *) otherButtonTitles, ...
{
    if ( (self = [super init] ) ) // will call into initWithFrame, thus TSAlertViewInput_commonInit is called
    {
        self.title = t;
        self.message = m;
        self.delegate = d;
        
        if ( nil != cancelButtonTitle )
        {
            [self addButtonWithTitle: cancelButtonTitle ];
            self.cancelButtonIndex = 0;
        }
        
        if ( nil != otherButtonTitles )
        {
            firstOtherButtonIndex = [self.buttons count];
            [self addButtonWithTitle: otherButtonTitles ];
            
            va_list args;
            va_start(args, otherButtonTitles);
            
//            id arg;
//            while ( nil != ( arg = va_arg( args, id ) ) )
//            {
//                if ( ![arg isKindOfClass: [NSString class] ] )
//                    return nil;
//                
//                [self addButtonWithTitle: (NSString*)arg ];
//            }
        }
    }
    
    return self;
}

- (CGSize) sizeThatFits: (CGSize) unused
{
    CGSize s = [self recalcSizeAndLayout: NO];
    return s;
}

- (void) layoutSubviews
{
    [self recalcSizeAndLayout: YES];
}

- (void) drawRect:(CGRect)rect
{
    [self.backgroundImage drawInRect: rect];
}

- (void)dealloc
{
    [_backgroundImage release];
    [_buttons release];
    [_titleLabel release];
    [_messageLabel release];
    [_messageTextView release];
    [_messageTextViewMaskImageView release];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self ];
    
    //NSLog( @"TSAlertViewInput: TSAlertOverlayWindow dealloc" );
    
    [super dealloc];
}


- (void) TSAlertViewInput_commonInit
{
    self.backgroundColor = [UIColor clearColor];
  //  self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    // defaults:
    style = TSAlertViewInputStyleNormal;
    self.width = 417; // set to default
    self.maxHeight = 643; // set to default
    buttonLayout = TSAlertViewInputButtonLayoutNormal;
    cancelButtonIndex = -1;
    firstOtherButtonIndex = -1;
    
    
    [self setBackgroundImage:[UIImage imageNamed:@"alert_bg.png"]];
    
}

- (void) setWidth:(CGFloat) w
{
    if ( w <= 0 )
        w = 284;
    
    width = MAX( w, self.backgroundImage.size.width );
}

- (CGFloat) width
{
    if ( nil == self.superview )
        return width;
    
    CGFloat maxWidth = self.superview.bounds.size.width - 20;
    
    return MIN( width, maxWidth );
}

- (void) setMaxHeight:(CGFloat) h
{
    if ( h <= 0 )
        h = 358;
    
    maxHeight = MAX( h, self.backgroundImage.size.height );
}

- (CGFloat) maxHeight
{
    if ( nil == self.superview )
        return maxHeight;
    
    return MIN( maxHeight, self.superview.bounds.size.height - 20 );
}

- (void) setStyle:(TSAlertViewInputStyle)newStyle
{
    if ( style != newStyle )
    {
        style = newStyle;
        
        if ( style == TSAlertViewInputStyleInput )
        {
            // need to watch for keyboard
            [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector( onKeyboardWillShow:) name: UIKeyboardWillShowNotification object: nil];
            [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector( onKeyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
        }
    }
}

- (void) onKeyboardWillShow: (NSNotification*) note
{
    NSValue* v = [note.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey];
    CGRect kbframe = [v CGRectValue];
    kbframe = [self.superview convertRect: kbframe fromView: nil];
    
    if ( CGRectIntersectsRect( self.frame, kbframe) )
    {
        CGPoint c = self.center;
        
        if ( self.frame.size.height > kbframe.origin.y - 20 )
        {
            self.maxHeight = kbframe.origin.y - 20;
            [self sizeToFit];
            [self layoutSubviews];
        }
        
        c.y = kbframe.origin.y / 2;
        
        [UIView animateWithDuration: 0.2
                         animations: ^{
                             self.center = c;
                             self.frame = CGRectIntegral(self.frame);
                         }];
    }
}

- (void) onKeyboardWillHide: (NSNotification*) note
{
    [UIView animateWithDuration: 0.2
                     animations: ^{
                         self.center = CGPointMake( CGRectGetMidX( self.superview.bounds ), CGRectGetMidY( self.superview.bounds ));
                         self.frame = CGRectIntegral(self.frame);
                     }];
}

- (NSMutableArray*) buttons
{
    if ( _buttons == nil )
    {
        _buttons = [[NSMutableArray arrayWithCapacity:4] retain];
    }
    
    return _buttons;
}

- (UILabel*) titleLabel
{
    if ( _titleLabel == nil )
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize: 15];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:5.0/255.0 green:122.0/255.0 blue:251.0/255.0 alpha:1.0];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

- (UILabel*) messageLabel
{
    if ( _messageLabel == nil )
    {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize: 13];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.textAlignment = UITextAlignmentCenter;
        _messageLabel.lineBreakMode = UILineBreakModeWordWrap;
        _messageLabel.numberOfLines = 0;
    }
    
    return _messageLabel;
}

- (UITextView*) messageTextView
{
    if ( _messageTextView == nil )
    {
        _messageTextView = [[UITextView alloc] init];
        _messageTextView.editable = NO;
        _messageTextView.font = [UIFont systemFontOfSize:13];
        _messageTextView.backgroundColor = [UIColor whiteColor];
        _messageTextView.textColor = [UIColor darkTextColor];
        _messageTextView.textAlignment = UITextAlignmentCenter;
        _messageTextView.bounces = YES;
        _messageTextView.alwaysBounceVertical = YES;
        _messageTextView.layer.cornerRadius = 5;
    }
    
    return _messageTextView;
}

- (UIImageView*) messageTextViewMaskView
{
    if ( _messageTextViewMaskImageView == nil )
    {
        UIImage* shadowImage = [[UIImage imageNamed:@"TSAlertViewInputMessageListViewShadow.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:7];
        
        _messageTextViewMaskImageView = [[UIImageView alloc] initWithImage: shadowImage];
        _messageTextViewMaskImageView.userInteractionEnabled = NO;
        _messageTextViewMaskImageView.layer.masksToBounds = YES;
        _messageTextViewMaskImageView.layer.cornerRadius = 6;
    }
    return _messageTextViewMaskImageView;
}

- (UITextField*) inputTextField
{
    if ( _inputTextField == nil )
    {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    }
    
    return _inputTextField;
}

- (UIImage*) backgroundImage
{
    if ( _backgroundImage == nil )
    {
        self.backgroundImage = [[UIImage imageNamed: @"TSAlertViewInputBackground.png"] stretchableImageWithLeftCapWidth: 15 topCapHeight: 30];
    }
    
    return _backgroundImage;
}

- (void) setTitle:(NSString *)t
{
    self.titleLabel.text = t;
}

- (NSString*) title
{
    return self.titleLabel.text;
}

- (void) setMessage:(NSString *)t
{
    self.messageLabel.text = t;
    self.messageTextView.text = t;
}

- (NSString*) message
{
    return self.messageLabel.text;
}

- (NSInteger) numberOfButtons
{
    return [self.buttons count];
}

- (void) setCancelButtonIndex:(NSInteger)buttonIndex
{
    // avoid a NSRange exception
    if ( buttonIndex < 0 || buttonIndex >= [self.buttons count] )
        return;
    
    cancelButtonIndex = buttonIndex;
    
    UIButton* b = [self.buttons objectAtIndex: buttonIndex];
    
    UIImage* buttonBgNormal = [UIImage imageNamed: @"TSAlertViewInputCancelButtonBackground.png"];
    buttonBgNormal = [buttonBgNormal stretchableImageWithLeftCapWidth: buttonBgNormal.size.width / 2.0 topCapHeight: buttonBgNormal.size.height / 2.0];
    //[b setBackgroundImage: buttonBgNormal forState: UIControlStateNormal];
    
    // [b setBackgroundColor: [UIColor colorWithRed:5.0/255.0 green:122.0/255.0 blue:251.0/255.0 alpha:1.0]];
    b.titleLabel.font=[UIFont systemFontOfSize:13.0];
    
    UIImage* buttonBgPressed = [UIImage imageNamed: @"TSAlertViewInputButtonBackground_Highlighted.png"];
    buttonBgPressed = [buttonBgPressed stretchableImageWithLeftCapWidth: buttonBgPressed.size.width / 2.0 topCapHeight: buttonBgPressed.size.height / 2.0];
    //[b setBackgroundImage: buttonBgPressed forState: UIControlStateHighlighted];
    b.layer.cornerRadius=5.0;
    b.layer.masksToBounds=YES;
}

- (BOOL) isVisible
{
    return self.superview != nil;
}

- (NSInteger) addButtonWithTitle: (NSString *) t
{
    UIButton* b = [UIButton buttonWithType: UIButtonTypeCustom];
    [b setTitle: t forState: UIControlStateNormal];
    
    UIImage* buttonBgNormal = [UIImage imageNamed: @"TSAlertViewInputButtonBackground.png"];
    buttonBgNormal = [buttonBgNormal stretchableImageWithLeftCapWidth: buttonBgNormal.size.width / 2.0 topCapHeight: buttonBgNormal.size.height / 2.0];
    [b setBackgroundImage: buttonBgNormal forState: UIControlStateNormal];
    
    //[b setBackgroundColor: [UIColor colorWithRed:5.0/255.0 green:122.0/255.0 blue:251.0/255.0 alpha:1.0]];
    
    b.titleLabel.font=[UIFont systemFontOfSize:13.0];
    
    UIImage* buttonBgPressed = [UIImage imageNamed: @"TSAlertViewInputButtonBackground_Highlighted.png"];
    buttonBgPressed = [buttonBgPressed stretchableImageWithLeftCapWidth: buttonBgPressed.size.width / 2.0 topCapHeight: buttonBgPressed.size.height / 2.0];
    //[b setBackgroundImage: buttonBgPressed forState: UIControlStateHighlighted];
    
    b.layer.cornerRadius=7.0;
    b.layer.masksToBounds=YES;
    
    
    [b addTarget: self action: @selector(onButtonPress:) forControlEvents: UIControlEventTouchUpInside];
    
    [self.buttons addObject: b];
    
    [self setNeedsLayout];
    
    return self.buttons.count-1;
}

- (NSString *) buttonTitleAtIndex:(NSInteger)buttonIndex
{
    // avoid a NSRange exception
    if ( buttonIndex < 0 || buttonIndex >= [self.buttons count] )
        return nil;
    
    UIButton* b = [self.buttons objectAtIndex: buttonIndex];
    
    return [b titleForState: UIControlStateNormal];
}

- (void) dismissWithClickedButtonIndex: (NSInteger)buttonIndex animated: (BOOL) animated
{
    if ( self.style == TSAlertViewInputStyleInput && [self.inputTextField isFirstResponder] )
    {
        [self.inputTextField resignFirstResponder];
    }
    
    if ( [self.delegate respondsToSelector: @selector(alertView:willDismissWithButtonIndex:)] )
    {
        [self.delegate alertView: self willDismissWithButtonIndex: buttonIndex ];
    }
    
    if ( animated )
    {
        self.window.backgroundColor = [UIColor clearColor];
        self.window.alpha = 1;
        
        [UIView animateWithDuration: 0.2
                         animations: ^{
                             [self.window resignKeyWindow];
                             self.window.alpha = 0;
                         }
                         completion: ^(BOOL finished) {
                             [self releaseWindow: buttonIndex];
                         }];
        
        [UIView commitAnimations];
    }
    else
    {
        [self.window resignKeyWindow];
        
        [self releaseWindow: buttonIndex];
    }
}

- (void) releaseWindow: (int) buttonIndex
{
    if ( [self.delegate respondsToSelector: @selector(alertView:didDismissWithButtonIndex:)] )
    {
        [self.delegate alertView: self didDismissWithButtonIndex: buttonIndex ];
    }
    
    // the one place we release the window we allocated in "show"
    // this will propogate releases to us (TSAlertViewInput), and our TSAlertViewInputController
    
    [self.window release];
}

- (void) show
{
    
    if((self.title == nil) || [@"" isEqualToString:self.title]){
        [self setTitle:@""];
    }
    
    [self setTitle:[NSString stringWithFormat:@"%@\n",self.title]];
    
    
    if((self.message == nil) || [@"" isEqualToString:self.message]){
        [self setMessage:[NSString stringWithFormat:@"%@",self.message]];
    }
    [self setMessage:[NSString stringWithFormat:@"%@ \n ",self.message]];
    
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate date]];
    
    TSAlertViewInputController* avc = [[[TSAlertViewInputController alloc] init] autorelease];
    avc.view.backgroundColor = [UIColor clearColor];
    
    // $important - the window is released only when the user clicks an alert view button
    TSAlertOverlayWindow1* ow = [[TSAlertOverlayWindow1 alloc] initWithFrame: [UIScreen mainScreen].bounds];
    ow.alpha = 0.0;
    ow.backgroundColor = [UIColor clearColor];
    ow.rootViewController = avc;
    [ow makeKeyAndVisible];
    
    // fade in the window
    [UIView animateWithDuration: 0.2 animations: ^{
        ow.alpha = 1;
    }];
    
    // add and pulse the alertview
    // add the alertview
    [avc.view addSubview: self];
    [self sizeToFit];
    self.center = CGPointMake( CGRectGetMidX( avc.view.bounds ), CGRectGetMidY( avc.view.bounds ) );;
    self.frame = CGRectIntegral( self.frame );
    [self pulse];
    
    if ( self.style == TSAlertViewInputStyleInput )
    {
        [self layoutSubviews];
        [self.inputTextField becomeFirstResponder];
    }
    
}

- (void) pulse
{
    
    
    // pulse animation thanks to:  http://delackner.com/blog/2009/12/mimicking-TSAlertViewInputs-animated-transition/
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration: 0.2
                     animations: ^{
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion: ^(BOOL finished){
                         [UIView animateWithDuration:1.0/15.0
                                          animations: ^{
                                              self.transform = CGAffineTransformMakeScale(0.9, 0.9);
                                          }
                                          completion: ^(BOOL finished){
                                              [UIView animateWithDuration:1.0/7.5
                                                               animations: ^{
                                                                   self.transform = CGAffineTransformIdentity;
                                                               }];
                                          }];
                     }];
    
}

- (void) onButtonPress: (id) sender
{
    int buttonIndex = [_buttons indexOfObjectIdenticalTo: sender];
    if(self.delegate!=nil)
    {
        if ( [self.delegate respondsToSelector: @selector(alertView:clickedButtonAtIndex:)] )
        {
            [self.delegate alertView: self clickedButtonAtIndex: buttonIndex ];
        }
        
        if ( buttonIndex == self.cancelButtonIndex )
        {
            if ( [self.delegate respondsToSelector: @selector(alertViewCancel:)] )
            {
                [self.delegate alertViewCancel: self ];
            }
        }
    }
    
    [self dismissWithClickedButtonIndex: buttonIndex  animated: YES];
}

- (CGSize) recalcSizeAndLayout: (BOOL) layout
{
    BOOL	stacked = !(self.buttonLayout == TSAlertViewInputButtonLayoutNormal && [self.buttons count] == 2 );
    
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    
    CGSize  titleLabelSize = [self titleLabelSize];
    CGSize  messageViewSize = [self messageLabelSize];
    CGSize  inputTextFieldSize = [self inputTextFieldSize];
    CGSize  buttonsAreaSize = stacked ? [self buttonsAreaSize_Stacked] : [self buttonsAreaSize_SideBySide];
    
    CGFloat inputRowHeight = self.style == TSAlertViewInputStyleInput ? inputTextFieldSize.height + kTSAlertViewInput_RowMargin : 0;
    
    CGFloat totalHeight = kTSAlertViewInput_TopMargin + titleLabelSize.height + kTSAlertViewInput_RowMargin + messageViewSize.height + inputRowHeight + kTSAlertViewInput_RowMargin + buttonsAreaSize.height + kTSAlertViewInput_BottomMargin;
    
    if ( totalHeight > self.maxHeight )
    {
        // too tall - we'll condense by using a textView (with scrolling) for the message
        
        totalHeight -= messageViewSize.height;
        //$$what if it's still too tall?
        messageViewSize.height = self.maxHeight - totalHeight;
        
        totalHeight = self.maxHeight;
        
        self.usesMessageTextView = YES;
    }
    
    if ( layout )
    {
        // title
        CGFloat y = kTSAlertViewInput_TopMargin;
        if (self.title !=nil && ![self.title isEqualToString:@"\n"])
        {
            self.titleLabel.frame = CGRectMake( kTSAlertViewInput_LeftMargin, y, titleLabelSize.width, titleLabelSize.height );
            [self addSubview: self.titleLabel];
            y += titleLabelSize.height + kTSAlertViewInput_RowMargin;
        }
        
        // message
        if ( self.message != nil )
        {
            if ( self.usesMessageTextView )
            {
                y += 1;
                self.messageTextView.frame = CGRectMake( kTSAlertViewInput_LeftMargin, y, messageViewSize.width, messageViewSize.height );
                [self addSubview: self.messageTextView];
                y += messageViewSize.height + kTSAlertViewInput_RowMargin;
                
                UIImageView* maskImageView = [self messageTextViewMaskView];
                maskImageView.frame = self.messageTextView.frame;
                [self addSubview: maskImageView];
            }
            else
            {
                y += 1;
                self.messageLabel.frame = CGRectMake( kTSAlertViewInput_LeftMargin, y+15, messageViewSize.width, messageViewSize.height );
                [self addSubview: self.messageLabel];
                y += messageViewSize.height + kTSAlertViewInput_RowMargin;
            }
        }
        
        // input
        if ( self.style == TSAlertViewInputStyleInput )
        {
            self.inputTextField.frame = CGRectMake( kTSAlertViewInput_LeftMargin, y-15, inputTextFieldSize.width, inputTextFieldSize.height );
            [self addSubview: self.inputTextField];
            y += inputTextFieldSize.height + kTSAlertViewInput_RowMargin;
        }
        if (self.title !=nil && ![self.title isEqualToString:@"\n"])
        {
            y -=10;
        }
        else
            y += 10;
        // buttons
        CGFloat buttonHeight = [[self.buttons objectAtIndex:0] sizeThatFits: CGSizeZero].height;
        if ( stacked )
        {
            CGFloat buttonWidth = maxWidth;
            for ( UIButton* b in self.buttons )
            {
                b.frame = CGRectMake( kTSAlertViewInput_LeftMargin, y+18, buttonWidth, buttonHeight );
                [self addSubview: b];
                y += buttonHeight + kTSAlertViewInput_RowMargin;
            }
        }
        else
        {
            CGFloat buttonWidth = (maxWidth - kTSAlertViewInput_ColumnMargin) / 2.0;
            CGFloat x = kTSAlertViewInput_LeftMargin;
            for ( UIButton* b in self.buttons )
            {
                b.frame = CGRectMake( x, y+18, buttonWidth, buttonHeight );
                [self addSubview: b];
                x += buttonWidth + kTSAlertViewInput_ColumnMargin;
            }
        }
        
    }
    
    return CGSizeMake( self.width, totalHeight );
}

- (CGSize) titleLabelSize
{
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    CGSize s = [self.titleLabel.text sizeWithFont: self.titleLabel.font constrainedToSize: CGSizeMake(maxWidth, 1000) lineBreakMode: self.titleLabel.lineBreakMode];
    if ( s.width < maxWidth )
        s.width = maxWidth;
    
    return s;
}

- (CGSize) messageLabelSize
{
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    CGSize s = [self.messageLabel.text sizeWithFont: self.messageLabel.font constrainedToSize: CGSizeMake(maxWidth, 1000) lineBreakMode: self.messageLabel.lineBreakMode];
    if ( s.width < maxWidth )
        s.width = maxWidth;
    
    return s;
}

- (CGSize) inputTextFieldSize
{
    if ( self.style == TSAlertViewInputStyleNormal)
        return CGSizeZero;
    
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    
    CGSize s = [self.inputTextField sizeThatFits: CGSizeZero];
    
    return CGSizeMake( maxWidth, s.height );
}

- (CGSize) buttonsAreaSize_SideBySide
{
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    
    CGSize bs = [[self.buttons objectAtIndex:0] sizeThatFits: CGSizeZero];
    
    bs.width = maxWidth;
    
    return bs;
}

- (CGSize) buttonsAreaSize_Stacked
{
    CGFloat maxWidth = self.width - (kTSAlertViewInput_LeftMargin * 2);
    int buttonCount = [self.buttons count];
    
    CGSize bs = [[self.buttons objectAtIndex:0] sizeThatFits: CGSizeZero];
    
    bs.width = maxWidth;
    
    bs.height = (bs.height * buttonCount) + (kTSAlertViewInput_RowMargin * (buttonCount-1));
    
    return bs;
}


@end




