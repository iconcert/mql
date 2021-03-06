#property copyright "Copyright 2020, Anton Achrimov"
#property link      "https://vk.com/a9176222010"
#property version   "1.00"
#property strict

int start()
   {

   string filename;                      
   ResetLastError();
   filename=FileOpen("Sovetnic.json",FILE_READ|FILE_WRITE,"\n");
   if(filename!=INVALID_HANDLE)
     {
      FileWrite(filename, AccountNumber(),AccountInfoString(ACCOUNT_COMPANY),AccountCurrency(),AccountInfoString(ACCOUNT_SERVER),AccountCompany(),AccountCurrency());
      FileClose(filename);
      Print("FileOpen OK");
     }
   else Print("Операция FileOpen неудачна, ошибка ",GetLastError());
   
   
   Print("");
   Sleep(60000);
   Print("Номер счета = ", AccountNumber());
   Print("Название торгового сервера = ",AccountInfoString(ACCOUNT_SERVER));
   Print("Счет зарегистрирован в компании ", AccountCompany());
   Print("Валюта счета - ", AccountCurrency());
   Print("Имя брокера = ",AccountInfoString(ACCOUNT_COMPANY));
   Print("Валюта депозита = ",AccountInfoString(ACCOUNT_CURRENCY));
   Print("Имя клиента = ",AccountInfoString(ACCOUNT_NAME));
   OnStart1();
   history();
   trading();
   OrderLots1();
   OrderOpenPrice1();
   OrderOpenTime1();
   OrderProfit1();
   OrderTicket1();
   OrderTakeProfit1();
   Order();
   return 0;
   }
   
void trading()
   {
   Print("");
   Print("Баланс счета в валюте депозита =  ",AccountInfoDouble(ACCOUNT_BALANCE));
   Print("Размер предоставленного кредита в валюте депозита =  ",AccountInfoDouble(ACCOUNT_CREDIT));
   Print("Размер текущей прибыли на счете в валюте депозита =  ",AccountInfoDouble(ACCOUNT_PROFIT));
   Print("Значение собственных средств на счете в валюте депозита =  ",AccountInfoDouble(ACCOUNT_EQUITY));
   Print("Размер зарезервированных залоговых средств на счете  в валюте депозита =  ",AccountInfoDouble(ACCOUNT_MARGIN));
   Print("Размер свободных средств на счете  в валюте депозита, доступных для открытия ордера =  ",AccountInfoDouble(ACCOUNT_FREEMARGIN));
   Print("Уровень залоговых средств на счете в процентах =  ",AccountInfoDouble(ACCOUNT_MARGIN_LEVEL));
   Print("ACCOUNT_MARGIN_SO_CALL = ",AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL));
   Print("ACCOUNT_MARGIN_SO_SO = ",AccountInfoDouble(ACCOUNT_MARGIN_SO_SO));
   Print("Баланс счета = ",AccountBalance());
   Print("Средства счета = ",AccountEquity());
   Print("Свободная маржа счета = ",AccountFreeMargin());
   Print("Маржа, взимаемая с перекрытых ордеров в расчете на 1 лот = ",MarketInfo(Symbol(),MODE_MARGINHEDGED));
   Print("Прибыль = ", AccountProfit());
   Print("Значение уровня, по которому определяется состояние Stop Out = ", AccountStopoutLevel());
   Print("Сумма залоговых средств = ", AccountMargin());
   Print("Общее количество открытых и отложенных ордеров = ", OrdersTotal());
   Print("Цена закрытия выбранного ордера = ", OrderClosePrice());
   Print("Время закрытия выбранного ордера = ", OrderCloseTime());
   Print("Дата истечения выбранного отложенного ордера = ", OrderExpiration());
   Print("Stop loss значение для ордера = ", OrderStopLoss());
   Print("Swap для ордера = ", OrderSwap());
   }
 
    
void history()
   {
   Print("");
   Print("Количество закрытых и удаленных ордеров в истории текущего счета = ", OrdersHistoryTotal());
   Print("Количество баров на текущем графике = ",Bars);
   Print("Размер свободных средств, необходимых для открытия 1 лота на покупку = ",MarketInfo(Symbol(),MODE_MARGINREQUIRED));
   Print("Уровень заморозки ордеров в пунктах = ",MarketInfo(Symbol(),MODE_FREEZELEVEL));
   }
   
void OrderLots1()
{
    if(OrderSelect(10,SELECT_BY_POS)==true)
    Print("Лоты для ордера ",OrderLots());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void OrderOpenPrice1()
{
    if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("Цена открытия для ордера ",OrderOpenPrice());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void OrderOpenTime1()
{
    if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("Время открытия для ордера ", OrderOpenTime());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void OrderProfit1()
{
    if(OrderSelect(10, SELECT_BY_POS)==true)
    Print("Чистая прибыль для ордера ",OrderProfit());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void OrderTicket1()
{
    if(OrderSelect(12, SELECT_BY_POS)==true)
    Print("Наименование финансового инструмента текущего выбранного ордера", OrderTicket(), " is ", OrderSymbol());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void OrderTakeProfit1()
{
  if(OrderSelect(12, SELECT_BY_POS)==true)
    Print("Значение цены закрытия ордера при достижении уровня прибыльности (take profit)",OrderTicket()," profit: ", OrderTakeProfit());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}

void Order()
{
    if(OrderSelect(12, SELECT_BY_POS)==true)
    Print("Номер тикета текущего выбранного ордера",OrderTicket()," profit: ", OrderTakeProfit());
  else
    Print("OrderSelect() вернул ошибку - ",GetLastError());
}
   
void OnStart1()
  {
//--- выведем всю информацию, доступную из функции AccountInfoInteger()
   printf("ACCOUNT_LOGIN =  %d",AccountInfoInteger(ACCOUNT_LOGIN));
   printf("ACCOUNT_LEVERAGE =  %d",AccountInfoInteger(ACCOUNT_LEVERAGE));
   bool thisAccountTradeAllowed=AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);
   bool EATradeAllowed=AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
   ENUM_ACCOUNT_TRADE_MODE tradeMode=(ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
   ENUM_ACCOUNT_STOPOUT_MODE stopOutMode=(ENUM_ACCOUNT_STOPOUT_MODE)AccountInfoInteger(ACCOUNT_MARGIN_SO_MODE);
//--- сообщим о возможности совершения торговых операций
   if(thisAccountTradeAllowed)
      Print("Торговля для данного счета разрешена");
   else
      Print("Торговля для данного счета запрещена!");
//--- выясним - можно ли торговать на данном счету экспертами
   if(EATradeAllowed)
      Print("Торговля советниками для данного счета разрешена");
   else
      Print("Торговля советниками для данного счета запрещена!");
//--- выясним тип счета
   switch(tradeMode)
     {
      case(ACCOUNT_TRADE_MODE_DEMO):
         Print("Это демо счет");
         break;
      case(ACCOUNT_TRADE_MODE_CONTEST):
         Print("Это конкурсный счет");
         break;
      default:Print("Это реальный счет!");
     }
//--- выясним режим задания уровня StopOut
   switch(stopOutMode)
     {
      case(ACCOUNT_STOPOUT_MODE_PERCENT):
         Print("Уровень StopOut задается в процентах");
         break;
      default:Print("Уровень StopOut задается в денежном выражении");
     }
  }
   /*
история счета
открытые сделки
ордер
цена открытия
прибыль по каждой открытой сделки
закрытые сделки
баланс пополнения

все данные сохранять в формате json и удалять старые данные
*/


