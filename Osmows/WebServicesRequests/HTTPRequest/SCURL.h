//
//  SCURL.h
//  Restaurant
//
//  Created by Faizan Ali on 11/27/12.
//
//
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6      (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

//#define BASE_URL_DEVELOPMENT_UPDATED @"http://scws.advansoftdev.com//MobileWS.svc/"
#define BASE_URL_DEVELOPMENT_UPDATED @"http://86.96.203.47/MobileWS.svc/"

#define BASE_URL_DEVELOPMENT @"http://starschoice.com/mobile_services/services/"
#define BASE_URL_PRODUCTION @"http://starschoice.com/mobile_services/services/"
#define BASE_URL_STAGING @"http://v2.starschoice.com/mobile_services/services/"

#define REWARD_ITEMS @"reward_items.php"
#define USER_REWARD_POINTS @"reward_points.php"
#define USER_INFO @"getUserProfile"
#define USER_INFO_UPDATE @"updateProfile"
#define SHIPPING_ADDRESS @"shipping_address.php"
#define SHIPPING_ADDRESS_UPDATE @"shipping_address_update"
#define CHEKOUT @"checkout.php"
#define APP_MESSAGE @"app_startup_message.php"
#define AllBusinessSearch @"getAllBusinessSearch"
#define DEALS @"alerts.php"
#define USER_RAFLES @"my_raffles.php"
#define USER_LEDGER @"rewards_ledger.php"
#define RESERVER_TABLE @"reservetable.php"
#define RESERVATIONS @"reservations.php"
#define FORGET_PASSWORD @"forgot_password.php"
#define COUNTRY_LIST @"countries_list.php"
#define STARTUP_DATA @"getStartUpData"
#define GetAllReviews @"getAllReviews"
#define getReviewsByBusinessID @"getAllReviewsByBusinessID"
#define GetAllReviewsByUserID @"getAllReviewsByUserID" 
#define GetUserNewsFeed @"getNewsFeed"
#define reportToAdmin @"reportToAdmin"

#define GetNewsFeed @"getNewsFeedV3"
#define reservationApi @"reserve"
#define UpdateReservation @"updateReservationStatus"
#define GetAllRestaurant @"getAllRestaurant"
#define PRICERANGE_DATA @"getAllPriceRange"
#define GetMenu @"getAllRestaurantMenu"
#define GetUserLikes @"getAllLikes"
#define GetUserFavorite @"getAllFavorite"
#define SubmitReview @"addReview"
#define ReblogRequest @"repostNewsFeed"
#define RepostBusinessImageRequest @"repostBusinessImage"
#define RepostBusiness @"repostBusiness"
#define RepostReview @"repostBusinessReview"

#define DeleteNewsFeedReply @"deleteNewsFeedReply"
#define UpdateNewsFeedReply @"updateNewsFeedReply"
#define UpdateBusinessImageComments @"updateBusinessImageComments"

#define DeleteBusinessImageComments @"deleteBusinessImageComments"

#define SubmitReply @"addNewsFeedReply"
#define InsertBusinessImageComments @"insertBusinessImageComments"
#define DeleteReview @"deleteReview"
#define DeleteNewsFeed @"deleteNewsFeed"
#define HideNewsFeed @"hideNewsFeed"

#define CheckIn @"checkIn"
#define AddFeedback @"addFeedback"
#define AddImageRequest @"addImageMultiple"
#define AddCoverPhoto @"updateCoverImage"
#define AddBusiness @"addBusiness"
#define UpdateBusiness @"updateBusiness"
#define UpdateMenu @"updateRestaurantMenu"
#define GetAllFeatured @"getAllFeatured"
#define GetAllBusinessTiming @"getAllBusinessTiming"
#define GetKeyword @"getAllKeywords"
#define GetCategoryKeyword @"getAllCategorySearch"
#define GetNearbyBusinesses @"getAllBusinessNearby"
#define GetBusinessImage @"getAllImagesByBusinessID"
#define GetBusinessbyName @"getAllBusinessSearchByName"

#define GetAllRestaurantMenuCategory @"getAllMenuCategory"
#define GetAllRestaurantMenuItem @"getAllMenuitems"
#define GETBUSINESSES @"getAllBusiness"
#define DeleteBusinessImage @"deleteBusinessImage"

#define GETRESERVATIONS @"getAllReservation"
#define UpdateFavorite @"updateFavorite"

#define UserValidate @"validateUser"
#define SocialUserValidate @"socialMediaLogin"
#define GETBusinessDetails @"getBusiness"
#define GetAllBusinessImages @"getAllImages"
#define UpdateLike @"updateLike"
#define UpdateRatingAndWishList @"updateRatingAndWishList"
#define repostNewsFeed @"repostNewsFeed"
#define updateBusinessImage @"updateBusinessIamge"
#define getAllBlog @"getAllBlog"
#define getSearchBlog @"searchBlog"

#define addBlog @"addBlog"
#define updateBlog @"updateBlog"

#define DEVICE_TOKEN @"updateDevice"
#define UPDATE_SETTINGS @"updateDevice"
#define VIEW_RESERVATIONS @"viewreservation.php"
#define UPDATE_RESERVATION @"updatereservation.php"
#define RESET_NOTIFICATION @"reset_notification_count.php"
#define MOST_POPULAR @"most_reserved_resturant.php"  
#define SIGNUP @"signup"
#define GetAllUsers @"getAllUsers"
#define FollowRequest @"followUser"
#define FollowBlogRequest @"followBlog"
#define UnFollowBlogRequest @"unFollowBlog"
#define BlockUserRequest @"blockUser"
#define UnBlockUserRequest @"unBlockUser"


#define UserFriendRequest @"followUser"
#define UserUnFriendRequest @"unFollowUser"
#define getAllUserNotifications @"getAllUserNotifications"

#define updateFriendRequestStatus @"updateFriendshipRequest"

#define BlogSearchKeywordsRequest @"searchBlogKeyword"
#define GetAllBlogsByUserID @"getAllUserBlog"
#define get3FInfo @"get3FInfo"
#define GetAllFriends @"getAllFriends"

#define UnFollowRequest @"unFollowUser"
#define PhoneBookSearch @"phoneBookSearch"
#define CheckFriendStatus @"checkFollowerStatus"


#define getUserConversation @"getAllUserMessage"
#define addUserConversation @"addUserMessage"
#define feedbackSubject @"getAllFeedbackSubject"

#define suggestCategory @"suggestCateogory"

#define SyncTime_Businesses @"SyncTimeForBusinessesData"
#define SyncTime_PriceRages @"SyncTimeForPriceRages"
#define SyncTime_UserLike @"SyncTimeForPriceRages"

#define getBlogSuggestKeyword @"getAllBlogSugestedKeyword"
#define getBlogSuggest @"getAllBlogSuggested"
