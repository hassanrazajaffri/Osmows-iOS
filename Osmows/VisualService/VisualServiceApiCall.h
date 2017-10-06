// VisualServiceProxy.m
//  Osmows
//
//  Created by Hassan Jaffri on 6/9/17.
//  Copyright © 2017 ZL Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xpathquery.h"
#import "VisualService.h"
#import "EnterpriseUser.h"

#ifndef _Wsdl2CodeProxyDelegate
#define _Wsdl2CodeProxyDelegate
@protocol Wsdl2CodeProxyDelegate
//if service recieve an error this method will be called
-(void)proxyRecievedError:(NSException*)ex InMethod:(NSString*)method;
//proxy finished, (id)data is the object of the relevant method service
-(void)proxydidFinishLoadingData:(id)data InMethod:(NSString*)method;
@end
#endif

@interface VisualServiceProxy : NSObject
@property (nonatomic,assign) id<Wsdl2CodeProxyDelegate> proxyDelegate;
@property (nonatomic,copy)   NSString* url;
@property (nonatomic,retain) VisualService* service;

-(id)initWithUrl:(NSString*)url AndDelegate:(id<Wsdl2CodeProxyDelegate>)delegate;
///Origin Return Type:NSString
-(void)GetOperationDate:(NSString *)sStoreNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)UpdateAccount:(NSString *)accountInfo :(NSString *)entId :(NSString *)storeNumber :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetItemDetailByItemCode:(NSString *)storeList :(NSString *)itemCode :(NSString *)entID :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetItemMaitenanceData:(NSString *)storeList :(NSString *)entID :(NSString *)credential ;
///Origin Return Type:NSString
-(void)SaveReferenceData:(NSString *)tableType :(NSString *)refDataXml :(NSString *)storeList :(NSString *)entId :(BOOL)isOneRecord :(BOOL)isOneRecordSpecified :(NSString *)itemCode :(NSString *)credential ;
///Origin Return Type:NSString
-(void)SaveData:(NSString *)dsXml :(NSString *)sqlQuery :(NSString *)tableName :(NSString *)dbName :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)DeleteMenuByItemCode:(NSString *)itemCode :(NSString *)storeList :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)ChangeItemCode:(NSString *)storeList :(NSString *)newItemCode :(NSString *)oldItemCode :(NSString *)deleteArchive :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCheckHeaderList:(NSString *)fromDate :(NSString *)toDate :(NSString *)storeNumber :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCheckInfo:(NSString *)transactionDate :(NSString *)checkNo :(NSString *)storeNumber :(NSString *)dbName :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetPurchaseInvoiceList:(NSString *)fromDate :(NSString *)toDate :(NSString *)storeNumber :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)UpdateItem:(NSString *)itemInfo :(NSString *)storeNumber :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetAccountList:(NSString *)fromDate :(NSString *)toDate :(NSString *)storeNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)ResetAccountBalance:(NSString *)accountInfo :(NSString *)entId :(NSString *)storeNumber :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetGCList:(NSString *)gcNo :(NSString *)entId :(NSString *)storeNumber :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetGCTransactions:(NSString *)gcNo :(NSString *)entId :(NSString *)storeNumber :(NSString *)fromDate :(NSString *)toDate :(NSString *)credential ;
///Origin Return Type:NSString
-(void)CreateGCTransaction:(NSString *)gcCardInfo :(NSString *)entId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddCustomerToCheck:(NSString *)orderInfo :(NSString *)guestNo :(NSString *)isDelete :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddAdjustmentToCheck:(NSString *)adjustmentInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddVipTagToCheck:(NSString *)CheckNo :(NSString *)TransactionDate :(NSString *)StoreNumber :(NSString *)AccountNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddMemoToCheck:(NSString *)CheckNo :(NSString *)TransactionDate :(NSString *)StoreNumber :(NSString *)Memo :(NSString *)GuestNo :(NSString *)sentToKitchen :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddPaymentToCheck:(NSString *)paymentInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)CheckLinkAlive:(NSString *)storenumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetAccount:(NSString *)paramInfo ;
///Origin Return Type:NSString
-(void)CompletePendingTopupTrans:(NSString *)sEntId :(NSString *)orderId :(NSString *)approveCode :(NSString *)transType :(NSString *)credential ;
///Origin Return Type:NSString
-(void)PrintBill:(NSString *)Checkno :(NSString *)TransactionDate :(NSString *)StoreNumber :(NSString *)GuestNoToPrint :(NSString *)CombinedBill :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetZonePrices:(NSString *)paramInfo ;
///Origin Return Type:NSString
-(void)GetPanelList:(NSString *)paramInfo ;
///Origin Return Type:NSString
-(void)UpdateGatewayData:(NSString *)sqlQuery :(NSString *)sTablename :(NSString *)sDbName :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCheckList:(NSString *)fromDate :(NSString *)toDate :(NSString *)storeList :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)ExecuteQuery:(NSString *)sqlQuery :(NSString *)sTablename :(NSString *)dbName :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetHouseAccountList:(NSString *)sFilter :(NSString *)byWhat :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetProfitCentreList:(NSString *)storelist :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetSupplierList:(NSString *)storelist :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetGroupList:(NSString *)storelist :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetGroups:(NSString *)sStoreNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCategories:(NSString *)sStoreNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetSizeList:(NSString *)sStoreNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetItemList:(NSString *)sEntId :(NSString *)sStoreList :(NSString *)xmlGroups :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetItemGroupList:(NSString *)sEntId :(NSString *)sStoreList :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetEmployeeList:(NSString *)sEntId :(NSString *)sStoreList :(NSString *)credential ;
///Origin Return Type:NSString
-(void)ResetEntUserPassword:(NSString *)sEmail :(NSString *)newPassword :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetLoyaltyInfo:(NSString *)sLogin :(NSString *)sPassword :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)UpdateLoyaltyInfo:(NSString *)sUserInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)CreateLoyaltyInfo:(NSString *)userInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)TopupLoyaltyCard:(NSString *)sCardNumber :(NSString *)sEntId :(NSString *)topUpAmount :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCardTransaction:(NSString *)sCardNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)UpdatePendingTrans:(NSString *)sTransInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetLoyaltyInfoWC:(NSString *)sCardNumber :(NSString *)sPassword :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)CreateOrder:(NSString *)orderInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetItems:(NSString *)paramInfo ;
///Origin Return Type:NSString
-(void)GetItemImageByItemCode:(NSString *)paramInfo ;
///Origin Return Type:NSString
-(void)CreateCheck:(NSString *)checkInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetCheck:(NSString *)CheckNo :(NSString *)TransactionDate :(NSString *)StoreNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)SendReceiptEmail:(NSString *)checkParamInfo ;
///Origin Return Type:NSString
-(void)GetGuestCheck:(NSString *)Checkno :(NSString *)transDate :(NSString *)storeNumber :(NSString *)guestNo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetlastOpenCheckNoByTableNo:(NSString *)tableNo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetlastOpenTableCheck:(NSString *)tableNo :(NSString *)storeNumber :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)AddItemsToCheck:(NSString *)checkInfo :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:EnterpriseUser
-(void)AuthorizeUser:(NSString *)userName :(NSString *)userPass :(NSString *)hostNames :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)UpdateUser:(EnterpriseUser *)entUser :(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetReport:(NSString *)reportParam :(NSString *)storeList :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetEnterpriseList:(NSString *)sEntId :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetData:(NSString *)sEntId :(NSString *)sqlQuery :(NSString *)sTablename :(NSString *)sDbName :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetDataSchema:(NSString *)sEntId :(NSString *)sqlQuery :(NSString *)sTablename :(NSString *)sDbName :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetGateWayData:(NSString *)sqlQuery :(NSString *)sTablename :(NSString *)sDbName :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetDayList:(NSString *)sEntId :(NSString *)sTablename :(NSString *)sStoreList :(NSString *)credential ;
///Origin Return Type:NSString
-(void)GetInvGroupList:(NSString *)sEntId :(NSString *)sStoreList :(NSString *)credential ;
@end
