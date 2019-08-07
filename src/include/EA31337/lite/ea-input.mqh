//+------------------------------------------------------------------+
//|                 EA31337 - multi-strategy advanced trading robot. |
//|                       Copyright 2016-2019, 31337 Investments Ltd |
//|                                       https://github.com/EA31337 |
//|                                                     ea-input.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, kenorb" // ©
#property link      "https://github.com/EA31337"

//+------------------------------------------------------------------+
//| Includes.
//+------------------------------------------------------------------+
#include "..\ea-enums.mqh"

//+------------------------------------------------------------------+
//| User input variables.
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
extern string __Trade_Parameters__ = "-- Trade parameters --"; // >>> TRADE <<<
extern uint   MaxOrders = 0; // Max orders (0 = auto)
extern uint   MaxOrdersPerType = 0; // Max orders per type (0 = auto)
uint   MaxOrdersPerDay = 0; // Max orders per day (0 = unlimited)
extern double LotSize = 0; // Lot size (0 = auto)
extern bool   TradeMicroLots = 1; // Trade micro lots?
int           TrendMethod = 0; // Main trend method (0-255)
extern int    MinVolumeToTrade = 2; // Min volume to trade
extern int    MaxOrderPriceSlippage = 50; // Max price slippage (in pts)
extern int    MaxTries = 5; // Max retries for opening orders
extern double MinPipChangeToTrade = 0.0; // Min pip change to trade
extern int    MinPipGap = 10; // Min gap between trades per type (in pips)
//extern uint   TickProcessMethod = 0; // Tick process method (0-8, 0 - all)

//+------------------------------------------------------------------+
extern string   __EA_Order_Parameters__ = "-- Profit and loss parameters --"; // >>> PROFIT/LOSS <<<
extern uint     TakeProfitMax = 0; // Max Take profit (in pips, 0 = auto)
extern uint     StopLossMax = 40; // Max Stop loss (in pips, 0 = auto)

//+------------------------------------------------------------------+
extern string __EA_Trailing_Parameters__ = "-- Profit and loss trailing parameters --"; // >>> TRAILINGS <<<
ENUM_TRAIL_TYPE DefaultTrailingStopMethod = 0; // Default trail stop method (0 = none)
ENUM_TRAIL_TYPE DefaultTrailingProfitMethod = 0; // Default trail profit method
extern int TrailingStop = 50; // Extra trailing stop (in pips)
extern int TrailingProfit = 0; // Extra trailing profit (in pips)
extern double TrailingStopAddPerMinute = 0.3; // Decrease trail stop per minute (pip/min)

//+------------------------------------------------------------------+
extern string __EA_Risk_Parameters__ = "-- Risk management parameters --"; // >>> RISK <<
extern double RiskMarginPerOrder = 1; // Risk margin per order (in %, 0-100, 0 - auto, -1 - off)
extern double RiskMarginTotal = 5; // Risk margin in total (in %, 0-100, 0 - auto, -1 - off)
extern double RiskRatio = 0; // Risk ratio (0 = auto, 1.0 = normal)
extern int RiskRatioIncreaseMethod = 0; // Risk ratio increase method (0-255)
extern int RiskRatioDecreaseMethod = 0; // Risk ratio decrease method (0-255)
extern int InitNoOfDaysToWarmUp = 14; // Initial warm-up period (in days)
extern double CloseOrderAfterXHours = 96; // Close order after X hours (>0 - all, <0 - only profitable 0 - off)

//+------------------------------------------------------------------+
extern string __Strategy_Parameters__ = "-- Per strategy parameters (0 to disable) --"; // >>> STRATEGIES <<<
extern double ProfitFactorMinToTrade = 0.9; // Min. profit factor per strategy to trade
extern double ProfitFactorMaxToTrade = 0.0; // Max. profit factor per strategy to trade
extern int InitNoOfOrdersToCalcPF = 20; // Initial number of orders to calculate profit factor

//+------------------------------------------------------------------+
extern string __Strategy_Boosting_Parameters__ = "-- Strategy boosting parameters (set 1.0 for default) --"; // >>> BOOSTING <<<
extern bool Boosting_Enabled = 0; // Enable boosting
extern double BoostTrendFactor = 0.9; // Boost by trend factor
extern bool StrategyBoostByPF = 1.1; // Boost strategy by its profit factor
extern bool StrategyHandicapByPF = true; // Handicap by its low profit factor
extern double BestDailyStrategyMultiplierFactor = 1.0; // Multiplier for the best daily strategy
extern double BestWeeklyStrategyMultiplierFactor = 1.0; // Multiplier for the best weekly strategy
extern double BestMonthlyStrategyMultiplierFactor = 1.0; // Multiplier for the best monthly strategy
extern double WorseDailyStrategyMultiplierFactor = 1.0; // Multiplier for the worse daily strategy
extern double WorseWeeklyStrategyMultiplierFactor = 1.0; // Multiplier for the worse weekly strategy
extern double WorseMonthlyStrategyMultiplierFactor = 1.0; // Multiplier for the worse monthly strategy
extern double ConWinsIncreaseFactor = 0.4; // Increase lot factor on consequent wins (in %, 0 - off)
extern double ConLossesIncreaseFactor = 0.7; // Increase lot factor on consequent loses (in %, 0 - off)
extern uint ConFactorOrdersLimit = 600; // No of orders to check on consequent wins/loses

//+------------------------------------------------------------------+
extern string __SmartQueue_Parameters__ = "-- Smart queue parameters --"; // >>> SMART QUEUE <<<
extern bool SmartQueueActive = 1; // Activate QueueAI
extern int SmartQueueMethod = 11; // QueueAI: Method for selecting the best order (0-15)
extern int SmartQueueFilter = 72; // QueueAI: Method for filtering the orders (0-255)

//+------------------------------------------------------------------+
extern string __EA_Account_Conditions__ = "-- Account conditions --"; // >>> CONDITIONS & ACTIONS <<<
extern bool Account_Conditions_Active = 0; // Enable account conditions (don't enable for multibot trading)
// Condition 5 - Equity 1% high
extern ENUM_ACC_CONDITION Account_Condition_1 = 5; // 1. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_1 = 5; // 1. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_1 = 10; // 1. Action to take
// Condition 6 - Equity 10% high
extern ENUM_ACC_CONDITION Account_Condition_2 = 0; // 2. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_2 = 8; // 2. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_2 = 7; // 2. Action to take
// Condition 10 - 50% Margin Used
extern ENUM_ACC_CONDITION Account_Condition_3 = 0; // 3. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_3 = 1; // 3. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_3 = 0; // 3. Action to take
// Condition 17 - Max. daily balance < max. weekly
extern ENUM_ACC_CONDITION Account_Condition_4 = 17; // 4. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_4 = 16; // 4. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_4 = 7; // 4. Action to take
//
extern ENUM_ACC_CONDITION Account_Condition_5 = 0; // 5. Account condition
extern ENUM_MARKET_CONDITION Market_Condition_5 = 0; // 5. Market condition
extern ENUM_ACTION_TYPE Action_On_Condition_5 = 0; // 5. Action to take

extern int Account_Condition_MinProfitCloseOrder = 20; // Min pip profit on action to close

//+------------------------------------------------------------------+
extern string __EA_Account_Conditions_Params__ = "-- Account conditions parameters --"; // >>> CONDITIONS & ACTIONS PARAMS <<<
extern int MarketSpecificHour = 10; // Specific hour used for conditions (0-23)
extern bool CloseConditionOnlyProfitable = 1; // Apply close condition only for profitable orders

//+------------------------------------------------------------------+
extern string __AC_Parameters__ = "-- Settings for the Bill Williams' Accelerator/Decelerator oscillator --"; // >>> AC <<<
extern uint AC_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern ENUM_TRAIL_TYPE AC_TrailingStopMethod = 3; // Trail stop method
extern ENUM_TRAIL_TYPE AC_TrailingProfitMethod = 22; // Trail profit method
extern double AC_SignalLevel = 0.0004; // Signal level (>0.0001)
extern uint AC_Shift = 0; // Shift (relative to the current bar, 0 - default)
extern int AC1_SignalMethod = 1; // Signal method for M1 (0-1)
extern int AC5_SignalMethod = 1; // Signal method for M5 (0-1)
extern int AC15_SignalMethod = 0; // Signal method for M15 (0-1)
extern int AC30_SignalMethod = 1; // Signal method for M30 (0-1)
int AC1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int AC1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT AC1_CloseCondition = C_AC_BUY_SELL; // Close condition for M1
int AC5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int AC5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT AC5_CloseCondition = C_AC_BUY_SELL; // Close condition for M5
int AC15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int AC15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT AC15_CloseCondition = C_AC_BUY_SELL; // Close condition for M15
int AC30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int AC30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT AC30_CloseCondition = C_AC_BUY_SELL; // Close condition for M30
double AC1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double AC5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double AC15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double AC30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __AD_Parameters__ = "-- Settings for the Accumulation/Distribution indicator --"; // >>> AD <<<
extern uint AD_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern ENUM_TRAIL_TYPE AD_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE AD_TrailingProfitMethod = 11; // Trail profit method
extern double AD_SignalLevel = 0.00000000; // Signal level
extern uint AD_Shift = 0; // Shift (relative to the current bar, 0 - default)
extern int AD1_SignalMethod = 0; // Signal method for M1 (0-?)
extern int AD5_SignalMethod = 0; // Signal method for M5 (0-?)
extern int AD15_SignalMethod = 0; // Signal method for M15 (0-?)
extern int AD30_SignalMethod = 0; // Signal method for M30 (0-?)
int AD1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int AD1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT AD1_CloseCondition = C_AD_BUY_SELL; // Close condition for M1
int AD5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int AD5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT AD5_CloseCondition = C_AD_BUY_SELL; // Close condition for M5
int AD15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int AD15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT AD15_CloseCondition = C_AD_BUY_SELL; // Close condition for M15
int AD30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int AD30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT AD30_CloseCondition = C_AD_BUY_SELL; // Close condition for M30
double AD1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double AD5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double AD15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double AD30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __ADX_Parameters__ = "-- Settings for the Average Directional Movement Index indicator --"; // >>> ADX <<<
extern uint ADX_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern ENUM_TRAIL_TYPE ADX_TrailingStopMethod = 11; // Trail stop method
extern ENUM_TRAIL_TYPE ADX_TrailingProfitMethod = 25; // Trail profit method
extern uint ADX_Period_M1 = 32; // Period for M1
extern uint ADX_Period_M5 = 20; // Period for M5
extern uint ADX_Period_M15 = 30; // Period for M15
extern uint ADX_Period_M30 = 34; // Period for M30
extern ENUM_APPLIED_PRICE ADX_Applied_Price = 3; // Applied Price
extern double ADX_SignalLevel = 18.5; // Signal level
extern uint ADX_Shift = 3; // Shift (relative to the current bar, 0 - default)
extern int ADX1_SignalMethod = 0; // Signal method for M1 (0-?)
extern int ADX5_SignalMethod = 0; // Signal method for M5 (0-?)
extern int ADX15_SignalMethod = 0; // Signal method for M15 (0-?)
extern int ADX30_SignalMethod = 0; // Signal method for M30 (0-?)
int ADX1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int ADX1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT ADX1_CloseCondition = C_ADX_BUY_SELL; // Close condition for M1
int ADX5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int ADX5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT ADX5_CloseCondition = C_ADX_BUY_SELL; // Close condition for M5
int ADX15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int ADX15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT ADX15_CloseCondition = C_ADX_BUY_SELL; // Close condition for M15
int ADX30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int ADX30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT ADX30_CloseCondition = C_ADX_BUY_SELL; // Close condition for M30
double ADX1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double ADX5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double ADX15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double ADX30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Alligator_Parameters__ = "-- Settings for the Alligator indicator --"; // >>> ALLIGATOR <<<
extern uint Alligator_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int Alligator_Period_Jaw = 16; // Jaw Period
extern int Alligator_Period_Teeth = 8; // Teeth Period
extern int Alligator_Period_Lips = 6; // Lips Period
extern int Alligator_Shift_Jaw = 5; // Jaw Shift
extern int Alligator_Shift_Teeth = 7; // Teeth Shift
extern int Alligator_Shift_Lips = 5; // Lips Shift
extern ENUM_MA_METHOD Alligator_MA_Method = 2; // MA Method
extern ENUM_APPLIED_PRICE Alligator_Applied_Price = 4; // Applied Price
extern int Alligator_Shift = 2; // Shift
extern ENUM_TRAIL_TYPE Alligator_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE Alligator_TrailingProfitMethod = 25; // Trail profit method
extern double Alligator_SignalLevel = 0.1; // Signal level
extern int Alligator1_SignalMethod = 19; // Signal method for M1 (-63-63)
extern int Alligator5_SignalMethod = 27; // Signal method for M5 (-63-63)
extern int Alligator15_SignalMethod = 20; // Signal method for M15 (-63-63)
extern int Alligator30_SignalMethod = 16; // Signal method for M30 (-63-63)
int Alligator1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Alligator1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT Alligator1_CloseCondition = C_ALLIGATOR_BUY_SELL; // Close condition for M1
int Alligator5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Alligator5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT Alligator5_CloseCondition = C_ALLIGATOR_BUY_SELL; // Close condition for M5
int Alligator15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int Alligator15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT Alligator15_CloseCondition = C_ALLIGATOR_BUY_SELL; // Close condition for M15
int Alligator30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int Alligator30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT Alligator30_CloseCondition = C_ALLIGATOR_BUY_SELL; // Close condition for M30
double Alligator1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Alligator5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Alligator15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Alligator30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __ATR_Parameters__ = "-- Settings for the Average True Range indicator --"; // >>> ATR <<<
uint ATR_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE ATR_TrailingStopMethod = 7; // Trail stop method
ENUM_TRAIL_TYPE ATR_TrailingProfitMethod = 22; // Trail profit method
int ATR_Period_M1 = 14; // Period for M1
int ATR_Period_M5 = 14; // Period for M5
int ATR_Period_M15 = 14; // Period for M15
int ATR_Period_M30 = 14; // Period for M30
double ATR_SignalLevel = 0.00000000; // Signal level
uint ATR_Shift = 0; // Shift (relative to the current bar, 0 - default)
int ATR1_SignalMethod = 0; // Signal method for M1 (0-31)
int ATR5_SignalMethod = 0; // Signal method for M5 (0-31)
int ATR15_SignalMethod = 0; // Signal method for M15 (0-31)
int ATR30_SignalMethod = 0; // Signal method for M30 (0-31)
int ATR1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int ATR1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT ATR1_CloseCondition = C_ATR_BUY_SELL; // Close condition for M1
int ATR5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int ATR5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT ATR5_CloseCondition = C_ATR_BUY_SELL; // Close condition for M5
int ATR15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int ATR15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT ATR15_CloseCondition = C_ATR_BUY_SELL; // Close condition for M15
int ATR30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int ATR30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT ATR30_CloseCondition = C_ATR_BUY_SELL; // Close condition for M30
double ATR1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double ATR5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double ATR15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double ATR30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __Awesome_Parameters__ = "-- Settings for the Awesome oscillator --"; // >>> AWESOME <<<
uint Awesome_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE Awesome_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE Awesome_TrailingProfitMethod = 1; // Trail profit method
double Awesome_SignalLevel = 0.00000000; // Signal level
uint Awesome_Shift = 0; // Shift (relative to the current bar, 0 - default)
int Awesome1_SignalMethod = 0; // Signal method for M1 (0-31)
int Awesome5_SignalMethod = 0; // Signal method for M5 (0-31)
int Awesome15_SignalMethod = 0; // Signal method for M15 (0-31)
int Awesome30_SignalMethod = 0; // Signal method for M30 (0-31)
int Awesome1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Awesome1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Awesome1_CloseCondition = C_AWESOME_BUY_SELL; // Close condition for M1
int Awesome5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Awesome5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Awesome5_CloseCondition = C_AWESOME_BUY_SELL; // Close condition for M5
int Awesome15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Awesome15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Awesome15_CloseCondition = C_AWESOME_BUY_SELL; // Close condition for M15
int Awesome30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Awesome30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Awesome30_CloseCondition = C_AWESOME_BUY_SELL; // Close condition for M30
double Awesome1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Awesome5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Awesome15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Awesome30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Bands_Parameters__ = "-- Settings for the Bollinger Bands indicator --"; // >>> BANDS <<<
extern uint Bands_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int Bands_Period_M1 = 2; // Period for M1
extern int Bands_Period_M5 = 2; // Period for M5
extern int Bands_Period_M15 = 2; // Period for M15
extern int Bands_Period_M30 = 2; // Period for M30
extern ENUM_APPLIED_PRICE Bands_Applied_Price = PRICE_CLOSE; // Applied Price
extern double Bands_Deviation_M1 = 0.3; // Deviation for M1
extern double Bands_Deviation_M5 = 0.3; // Deviation for M5
extern double Bands_Deviation_M15 = 0.3; // Deviation for M15
extern double Bands_Deviation_M30 = 0.3; // Deviation for M30
extern int Bands_HShift = 0; // Horizontal shift
extern int Bands_Shift = 0; // Shift (relative to the current bar, 0 - default)
extern ENUM_TRAIL_TYPE Bands_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE Bands_TrailingProfitMethod = 22; // Trail profit method
extern int Bands_SignalLevel = 18; // Signal level
extern int Bands1_SignalMethod = -85; // Signal method for M1 (-127-127)
extern int Bands5_SignalMethod = -74; // Signal method for M5 (-127-127)
extern int Bands15_SignalMethod = -127; // Signal method for M15 (-127-127)
extern int Bands30_SignalMethod = -127; // Signal method for M30 (-127-127)
int Bands1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Bands1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT Bands1_CloseCondition = C_BANDS_BUY_SELL; // Close condition for M1
int Bands5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Bands5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT Bands5_CloseCondition = C_BANDS_BUY_SELL; // Close condition for M5
int Bands15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int Bands15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT Bands15_CloseCondition = C_BANDS_BUY_SELL; // Close condition for M15
int Bands30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int Bands30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT Bands30_CloseCondition = C_BANDS_BUY_SELL; // Close condition for M30
double Bands1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Bands5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Bands15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Bands30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __BearsPower_Parameters__ = "-- Settings for the Bears Power indicator --"; // >>> BEARS POWER <<<
uint BearsPower_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE BearsPower_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE BearsPower_TrailingProfitMethod = 1; // Trail profit method
int BearsPower_Period = 13; // Period
ENUM_APPLIED_PRICE BearsPower_Applied_Price = PRICE_CLOSE; // Applied Price
double BearsPower_SignalLevel = 0.00000000; // Signal level
uint BearsPower_Shift = 0; // Shift (relative to the current bar, 0 - default)
int BearsPower1_SignalMethod = 0; // Signal method for M1 (0-
int BearsPower5_SignalMethod = 0; // Signal method for M5 (0-
int BearsPower15_SignalMethod = 0; // Signal method for M15 (0-
int BearsPower30_SignalMethod = 0; // Signal method for M30 (0-
int BearsPower1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int BearsPower1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT BearsPower1_CloseCondition = C_BEARSPOWER_BUY_SELL; // Close condition for M1
int BearsPower5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int BearsPower5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT BearsPower5_CloseCondition = C_BEARSPOWER_BUY_SELL; // Close condition for M5
int BearsPower15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int BearsPower15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT BearsPower15_CloseCondition = C_BEARSPOWER_BUY_SELL; // Close condition for M15
int BearsPower30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int BearsPower30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT BearsPower30_CloseCondition = C_BEARSPOWER_BUY_SELL; // Close condition for M30
double BearsPower1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double BearsPower5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double BearsPower15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double BearsPower30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __BullsPower_Parameters__ = "-- Settings for the Bulls Power indicator --"; // >>> BULLS POWER <<<
uint BullsPower_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE BullsPower_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE BullsPower_TrailingProfitMethod = 1; // Trail profit method
int BullsPower_Period = 13; // Period
ENUM_APPLIED_PRICE BullsPower_Applied_Price = PRICE_CLOSE; // Applied Price
double BullsPower_SignalLevel = 0.00000000; // Signal level
uint BullsPower_Shift = 0; // Shift (relative to the current bar, 0 - default)
int BullsPower1_SignalMethod = 0; // Signal method for M1 (0-
int BullsPower5_SignalMethod = 0; // Signal method for M5 (0-
int BullsPower15_SignalMethod = 0; // Signal method for M15 (0-
int BullsPower30_SignalMethod = 0; // Signal method for M30 (0-
int BullsPower1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int BullsPower1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT BullsPower1_CloseCondition = C_BULLSPOWER_BUY_SELL; // Close condition for M1
int BullsPower5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int BullsPower5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT BullsPower5_CloseCondition = C_BULLSPOWER_BUY_SELL; // Close condition for M5
int BullsPower15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int BullsPower15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT BullsPower15_CloseCondition = C_BULLSPOWER_BUY_SELL; // Close condition for M15
int BullsPower30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int BullsPower30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT BullsPower30_CloseCondition = C_BULLSPOWER_BUY_SELL; // Close condition for M30
double BullsPower1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double BullsPower5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double BullsPower15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double BullsPower30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __BWMFI_Parameters__ = "-- Settings for the Market Facilitation Index indicator --"; // >>> BWMFI <<<
uint BWMFI_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE BWMFI_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE BWMFI_TrailingProfitMethod = 1; // Trail profit method
double BWMFI_SignalLevel = 0.00000000; // Signal level
extern uint BWMFI_Shift = 0; // Shift (relative to the current bar, 0 - default)
int BWMFI1_SignalMethod = 0; // Signal method for M1 (0-
int BWMFI5_SignalMethod = 0; // Signal method for M5 (0-
int BWMFI15_SignalMethod = 0; // Signal method for M15 (0-
int BWMFI30_SignalMethod = 0; // Signal method for M30 (0-
int BWMFI1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int BWMFI1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT BWMFI1_CloseCondition = C_BWMFI_BUY_SELL; // Close condition for M1
int BWMFI5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int BWMFI5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT BWMFI5_CloseCondition = C_BWMFI_BUY_SELL; // Close condition for M5
int BWMFI15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int BWMFI15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT BWMFI15_CloseCondition = C_BWMFI_BUY_SELL; // Close condition for M15
int BWMFI30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int BWMFI30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT BWMFI30_CloseCondition = C_BWMFI_BUY_SELL; // Close condition for M30
double BWMFI1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double BWMFI5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double BWMFI15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double BWMFI30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __CCI_Parameters__ = "-- Settings for the Commodity Channel Index indicator --"; // >>> CCI <<<
extern uint CCI_Active_Tf = 15; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int CCI_Shift = 1; // Shift (0 for default)
extern ENUM_TRAIL_TYPE CCI_TrailingStopMethod = 1; // Trail stop method
extern ENUM_TRAIL_TYPE CCI_TrailingProfitMethod = 1; // Trail profit method
extern int CCI_Period_M1 = 58; // Period for M1
extern int CCI_Period_M5 = 22; // Period for M5
extern int CCI_Period_M15 = 18; // Period for M15
extern int CCI_Period_M30 = 26; // Period for M30
extern ENUM_APPLIED_PRICE CCI_Applied_Price = 2; // Applied Price
extern double CCI_SignalLevel = 98; // Signal level (100 by default)
extern int CCI1_SignalMethod = 34; // Signal method for M1 (0-63)
extern int CCI5_SignalMethod = 18; // Signal method for M5 (0-63)
extern int CCI15_SignalMethod = 0; // Signal method for M15 (0-63)
extern int CCI30_SignalMethod = -44; // Signal method for M30 (0-63)
int CCI1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int CCI1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT CCI1_CloseCondition = C_CCI_BUY_SELL; // Close condition for M1

int CCI5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int CCI5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT CCI5_CloseCondition = C_CCI_BUY_SELL; // Close condition for M5

int CCI15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int CCI15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT CCI15_CloseCondition = C_CCI_BUY_SELL; // Close condition for M15

int CCI30_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int CCI30_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT CCI30_CloseCondition = C_CCI_BUY_SELL; // Close condition for M30
double CCI1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double CCI5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double CCI15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double CCI30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __DeMarker_Parameters__ = "-- Settings for the DeMarker indicator --"; // >>> DEMARKER <<<
extern uint DeMarker_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int DeMarker_Period_M1 = 68; // Period for M1
extern int DeMarker_Period_M5 = 76; // Period for M5
extern int DeMarker_Period_M15 = 26; // Period for M15
extern int DeMarker_Period_M30 = 14; // Period for M30
extern int DeMarker_Shift = 1; // Shift
extern double DeMarker_SignalLevel = 0.5; // Signal level (0.0-0.5)
extern ENUM_TRAIL_TYPE DeMarker_TrailingStopMethod = 23; // Trail stop method
extern ENUM_TRAIL_TYPE DeMarker_TrailingProfitMethod = 22; // Trail profit method
extern int DeMarker1_SignalMethod = 12; // Signal method for M1 (-31-31)
extern int DeMarker5_SignalMethod = 12; // Signal method for M5 (-31-31)
extern int DeMarker15_SignalMethod = 4; // Signal method for M15 (-31-31)
extern int DeMarker30_SignalMethod = 12; // Signal method for M30 (-31-31)
int DeMarker1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int DeMarker1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT DeMarker1_CloseCondition = C_DEMARKER_BUY_SELL; // Close condition for M1
int DeMarker5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int DeMarker5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT DeMarker5_CloseCondition = C_DEMARKER_BUY_SELL; // Close condition for M5
int DeMarker15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int DeMarker15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT DeMarker15_CloseCondition = C_DEMARKER_BUY_SELL; // Close condition for M15
int DeMarker30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int DeMarker30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT DeMarker30_CloseCondition = C_DEMARKER_BUY_SELL; // Close condition for M30
double DeMarker1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double DeMarker5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double DeMarker15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double DeMarker30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Envelopes_Parameters__ = "-- Settings for the Envelopes indicator --"; // >>> ENVELOPES <<<
extern uint Envelopes_Active_Tf = 4; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int Envelopes_MA_Period_M1 = 6; // Period for M1
extern int Envelopes_MA_Period_M5 = 6; // Period for M5
extern int Envelopes_MA_Period_M15 = 22; // Period for M15
extern int Envelopes_MA_Period_M30 = 6; // Period for M30
extern double Envelopes_Deviation_M1 = 0.5; // Deviation for M1
extern double Envelopes_Deviation_M5 = 0.6; // Deviation for M5
extern double Envelopes_Deviation_M15 = 0.2; // Deviation for M15
extern double Envelopes_Deviation_M30 = 0.3; // Deviation for M30
extern ENUM_MA_METHOD Envelopes_MA_Method = 3; // MA Method
extern int Envelopes_MA_Shift = 0; // MA Shift
extern ENUM_APPLIED_PRICE Envelopes_Applied_Price = 3; // Applied Price
extern int Envelopes_Shift = 0; // Shift
extern ENUM_TRAIL_TYPE Envelopes_TrailingStopMethod = 23; // Trail stop method
extern ENUM_TRAIL_TYPE Envelopes_TrailingProfitMethod = -2; // Trail profit method
/* @todo extern */ int Envelopes_SignalLevel = 0; // Signal level
extern int Envelopes1_SignalMethod = 48; // Signal method for M1 (-127-127)
extern int Envelopes5_SignalMethod = 97; // Signal method for M5 (-127-127)
extern int Envelopes15_SignalMethod = 1; // Signal method for M15 (-127-127)
extern int Envelopes30_SignalMethod = 127; // Signal method for M30 (-127-127)
int Envelopes1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Envelopes1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT Envelopes1_CloseCondition = C_ENVELOPES_BUY_SELL; // Close condition for M1
int Envelopes5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Envelopes5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT Envelopes5_CloseCondition = C_ENVELOPES_BUY_SELL; // Close condition for M5
int Envelopes15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int Envelopes15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT Envelopes15_CloseCondition = C_ENVELOPES_BUY_SELL; // Close condition for M15
int Envelopes30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int Envelopes30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT Envelopes30_CloseCondition = C_ENVELOPES_BUY_SELL; // Close condition for M30
double Envelopes1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Envelopes5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Envelopes15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Envelopes30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Force_Parameters__ = "-- Settings for the Force Index indicator --"; // >>> FORCE <<<
extern uint Force_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern ENUM_TRAIL_TYPE Force_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE Force_TrailingProfitMethod = 22; // Trail profit method
extern int Force_Period_M1 = 38; // Period for M1
extern int Force_Period_M5 = 38; // Period for M5
extern int Force_Period_M15 = 12; // Period for M15
extern int Force_Period_M30 = 38; // Period for M30
extern ENUM_MA_METHOD Force_MA_Method = 0; // MA Method
extern ENUM_APPLIED_PRICE Force_Applied_Price = 2; // Applied Price
extern double Force_SignalLevel = 0; // Signal level
extern uint Force_Shift = 1; // Shift (relative to the current bar, 0 - default)
int Force1_SignalMethod = 0; // Signal method for M1 (0-
int Force5_SignalMethod = 0; // Signal method for M5 (0-
int Force15_SignalMethod = 0; // Signal method for M15 (0-
int Force30_SignalMethod = 0; // Signal method for M30 (0-
int Force1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Force1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Force1_CloseCondition = C_FORCE_BUY_SELL; // Close condition for M1
int Force5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Force5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Force5_CloseCondition = C_FORCE_BUY_SELL; // Close condition for M5
int Force15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Force15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Force15_CloseCondition = C_FORCE_BUY_SELL; // Close condition for M15
int Force30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Force30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Force30_CloseCondition = C_FORCE_BUY_SELL; // Close condition for M30
double Force1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Force5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Force15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Force30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Fractals_Parameters__ = "-- Settings for the Fractals indicator --"; // >>> FRACTALS <<<
extern uint Fractals_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int Fractals_Shift = 0; // Shift
extern ENUM_TRAIL_TYPE Fractals_TrailingStopMethod = 1; // Trail stop method
extern ENUM_TRAIL_TYPE Fractals_TrailingProfitMethod = 21; // Trail profit method
/* @todo extern */ int Fractals_SignalLevel = 0; // Signal level
extern int Fractals1_SignalMethod = 3; // Signal method for M1 (-3-3)
extern int Fractals5_SignalMethod = 3; // Signal method for M5 (-3-3)
extern int Fractals15_SignalMethod = 3; // Signal method for M15 (-3-3)
extern int Fractals30_SignalMethod = -2; // Signal method for M30 (-3-3)
int Fractals1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Fractals1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Fractals1_CloseCondition = C_FRACTALS_BUY_SELL; // Close condition for M1
int Fractals5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Fractals5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Fractals5_CloseCondition = C_FRACTALS_BUY_SELL; // Close condition for M5
int Fractals15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Fractals15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Fractals15_CloseCondition = C_FRACTALS_BUY_SELL; // Close condition for M15
int Fractals30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Fractals30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Fractals30_CloseCondition = C_FRACTALS_BUY_SELL; // Close condition for M30
double Fractals1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Fractals5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Fractals15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Fractals30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __Gator_Parameters__ = "-- Settings for the Gator oscillator --"; // >>> GATOR <<<
uint Gator_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
int Gator_Period_Jaw = 6; // Jaw Period
int Gator_Period_Teeth = 10; // Teeth Period
int Gator_Period_Lips = 8; // Lips Period
int Gator_Shift_Jaw = 5; // Jaw Shift
int Gator_Shift_Teeth = 7; // Teeth Shift
int Gator_Shift_Lips = 5; // Lips Shift
ENUM_MA_METHOD Gator_MA_Method = 2; // MA Method
ENUM_APPLIED_PRICE Gator_Applied_Price = 3; // Applied Price
int Gator_Shift = 2; // Shift
ENUM_TRAIL_TYPE Gator_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE Gator_TrailingProfitMethod = 1; // Trail profit method
double Gator_SignalLevel = 0.00000000; // Signal level
int Gator1_SignalMethod = 0; // Signal method for M1 (0-
int Gator5_SignalMethod = 0; // Signal method for M5 (0-
int Gator15_SignalMethod = 0; // Signal method for M15 (0-
int Gator30_SignalMethod = 0; // Signal method for M30 (0-
int Gator1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Gator1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Gator1_CloseCondition = C_GATOR_BUY_SELL; // Close condition // Close condition for M1
int Gator5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Gator5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Gator5_CloseCondition = C_GATOR_BUY_SELL; // Close condition for M5
int Gator15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Gator15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Gator15_CloseCondition = C_GATOR_BUY_SELL; // Close condition for M15
int Gator30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Gator30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Gator30_CloseCondition = C_GATOR_BUY_SELL; // Close condition for M30
double Gator1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Gator5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Gator15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Gator30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __Ichimoku_Parameters__ = "-- Settings for the Ichimoku Kinko Hyo indicator --"; // >>> ICHIMOKU <<<
uint Ichimoku_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE Ichimoku_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE Ichimoku_TrailingProfitMethod = 1; // Trail profit method
int Ichimoku_Period_Tenkan_Sen = 9; // Period Tenkan Sen
int Ichimoku_Period_Kijun_Sen = 26; // Period Kijun Sen
int Ichimoku_Period_Senkou_Span_B = 52; // Period Senkou Span B
double Ichimoku_SignalLevel = 0.00000000; // Signal level
int Ichimoku1_SignalMethod = 0; // Signal method for M1 (0-
int Ichimoku5_SignalMethod = 0; // Signal method for M5 (0-
int Ichimoku15_SignalMethod = 0; // Signal method for M15 (0-
int Ichimoku30_SignalMethod = 0; // Signal method for M30 (0-
int Ichimoku1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Ichimoku1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Ichimoku1_CloseCondition = C_ICHIMOKU_BUY_SELL; // Close condition for M1
int Ichimoku5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Ichimoku5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Ichimoku5_CloseCondition = C_ICHIMOKU_BUY_SELL; // Close condition for M5
int Ichimoku15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Ichimoku15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Ichimoku15_CloseCondition = C_ICHIMOKU_BUY_SELL; // Close condition for M15
int Ichimoku30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Ichimoku30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Ichimoku30_CloseCondition = C_ICHIMOKU_BUY_SELL; // Close condition for M30
double Ichimoku1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Ichimoku5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Ichimoku15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Ichimoku30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __MA_Parameters__ = "-- Settings for the Moving Average indicator --"; // >>> MA <<<
extern uint MA_Active_Tf = 5; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int MA_Period_Fast = 12; // Period Fast
extern int MA_Period_Medium = 12; // Period Medium
extern int MA_Period_Slow = 4; // Period Slow
extern int MA_Shift = 8; // Shift
extern int MA_Shift_Fast = 10; // Shift Fast (+1)
extern int MA_Shift_Medium = 10; // Shift Medium (+1)
extern int MA_Shift_Slow = 5; // Shift Slow (+1)
extern ENUM_MA_METHOD MA_Method = 1; // MA Method
extern ENUM_APPLIED_PRICE MA_Applied_Price = 6; // Applied Price
extern ENUM_TRAIL_TYPE MA_TrailingStopMethod = 23; // Trail stop method
extern ENUM_TRAIL_TYPE MA_TrailingProfitMethod = 16; // Trail profit method
extern double MA_SignalLevel = -0.6; // Signal level
extern int MA1_SignalMethod = 48; // Signal method for M1 (-127-127)
extern int MA5_SignalMethod = 49; // Signal method for M5 (-127-127)
extern int MA15_SignalMethod = 44; // Signal method for M15 (-127-127)
extern int MA30_SignalMethod = -127; // Signal method for M30 (-127-127)
int MA1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int MA1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT MA1_CloseCondition = C_MA_BUY_SELL; // Close condition for M1
int MA5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int MA5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT MA5_CloseCondition = C_MA_BUY_SELL; // Close condition for M5
int MA15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int MA15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT MA15_CloseCondition = C_MA_BUY_SELL; // Close condition for M15
int MA30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int MA30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT MA30_CloseCondition = C_MA_BUY_SELL; // Close condition for M30
double MA1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double MA5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double MA15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double MA30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __MACD_Parameters__ = "-- Settings for the Moving Averages Convergence/Divergence indicator --"; // >>> MACD <<<
extern uint MACD_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int MACD_Period_Fast = 23; // Period Fast
extern int MACD_Period_Slow = 21; // Period Slow
extern int MACD_Period_Signal = 10; // Period for signal
extern ENUM_APPLIED_PRICE MACD_Applied_Price = PRICE_CLOSE; // Applied Price
extern int MACD_Shift = 3; // Shift
extern ENUM_TRAIL_TYPE MACD_TrailingStopMethod = -1; // Trail stop method
extern ENUM_TRAIL_TYPE MACD_TrailingProfitMethod = -19; // Trail profit method
extern double MACD_SignalLevel = 0.1; // Signal level
extern int MACD1_SignalMethod = -26; // Signal method for M1 (-31-31)
extern int MACD5_SignalMethod = -31; // Signal method for M5 (-31-31)
extern int MACD15_SignalMethod = -25; // Signal method for M15 (-31-31)
extern int MACD30_SignalMethod = 4; // Signal method for M30 (-31-31)
int MACD1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int MACD1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT MACD1_CloseCondition = C_MACD_BUY_SELL; // Close condition for M1
int MACD5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int MACD5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT MACD5_CloseCondition = C_MACD_BUY_SELL; // Close condition for M5
int MACD15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int MACD15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT MACD15_CloseCondition = C_MACD_BUY_SELL; // Close condition for M15
int MACD30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int MACD30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT MACD30_CloseCondition = C_MACD_BUY_SELL; // Close condition for M30
double MACD1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double MACD5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double MACD15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double MACD30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __MFI_Parameters__ = "-- Settings for the Money Flow Index indicator --"; // >>> MFI <<<
extern uint MFI_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern ENUM_TRAIL_TYPE MFI_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE MFI_TrailingProfitMethod = 22; // Trail profit method
extern int MFI_Period_M1 = 2; // Period for M1
extern int MFI_Period_M5 = 22; // Period for M5
extern int MFI_Period_M15 = 8; // Period for M15
extern int MFI_Period_M30 = 12; // Period for M30
extern double MFI_SignalLevel = 0.9; // Signal level
extern uint MFI_Shift = 0; // Shift (relative to the current bar, 0 - default)
int MFI1_SignalMethod = 0; // Signal method for M1 (0-1)
int MFI5_SignalMethod = 0; // Signal method for M5 (0-1)
int MFI15_SignalMethod = 0; // Signal method for M15 (0-1)
int MFI30_SignalMethod = 0; // Signal method for M30 (0-1)
int MFI1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int MFI1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT MFI1_CloseCondition = C_MFI_BUY_SELL; // Close condition for M1

int MFI5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int MFI5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT MFI5_CloseCondition = C_MFI_BUY_SELL; // Close condition for M5

int MFI15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int MFI15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT MFI15_CloseCondition = C_MFI_BUY_SELL; // Close condition for M15

int MFI30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int MFI30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT MFI30_CloseCondition = C_MFI_BUY_SELL; // Close condition for M30

double MFI1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double MFI5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double MFI15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double MFI30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __Momentum_Parameters__ = "-- Settings for the Momentum indicator --"; // >>> MOMENTUM <<<
uint Momentum_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE Momentum_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE Momentum_TrailingProfitMethod = 1; // Trail profit method
int Momentum_Period = 12; // Period Fast
ENUM_APPLIED_PRICE Momentum_Applied_Price = PRICE_CLOSE; // Applied Price
double Momentum_SignalLevel = 0.00000000; // Signal level
int Momentum1_SignalMethod = 0; // Signal method for M1 (0-
int Momentum5_SignalMethod = 0; // Signal method for M5 (0-
int Momentum15_SignalMethod = 0; // Signal method for M15 (0-
int Momentum30_SignalMethod = 0; // Signal method for M30 (0-
int Momentum1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Momentum1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT Momentum1_CloseCondition = C_MOMENTUM_BUY_SELL; // Close condition for M1
int Momentum5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Momentum5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Momentum5_CloseCondition = C_MOMENTUM_BUY_SELL; // Close condition for M5
int Momentum15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Momentum15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Momentum15_CloseCondition = C_MOMENTUM_BUY_SELL; // Close condition for M15
int Momentum30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Momentum30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Momentum30_CloseCondition = C_MOMENTUM_BUY_SELL; // Close condition for M30
double Momentum1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Momentum5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Momentum15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Momentum30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __OBV_Parameters__ = "-- Settings for the On Balance Volume indicator --"; // >>> OBV <<<
uint OBV_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE OBV_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE OBV_TrailingProfitMethod = 1; // Trail profit method
ENUM_APPLIED_PRICE OBV_Applied_Price = PRICE_CLOSE; // Applied Price
double OBV_SignalLevel = 0.00000000; // Signal level
int OBV1_SignalMethod = 0; // Signal method for M1 (0-
int OBV5_SignalMethod = 0; // Signal method for M5 (0-
int OBV15_SignalMethod = 0; // Signal method for M15 (0-
int OBV30_SignalMethod = 0; // Signal method for M30 (0-
int OBV1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int OBV1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT OBV1_CloseCondition = C_OBV_BUY_SELL; // Close condition for M1
int OBV5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int OBV5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT OBV5_CloseCondition = C_OBV_BUY_SELL; // Close condition for M5
int OBV15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int OBV15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT OBV15_CloseCondition = C_OBV_BUY_SELL; // Close condition for M15
int OBV30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int OBV30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT OBV30_CloseCondition = C_OBV_BUY_SELL; // Close condition for M30
double OBV1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double OBV5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double OBV15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double OBV30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __OSMA_Parameters__ = "-- Settings for the Moving Average of Oscillator indicator --"; // >>> OSMA <<<
uint OSMA_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
ENUM_TRAIL_TYPE OSMA_TrailingStopMethod = 25; // Trail stop method
ENUM_TRAIL_TYPE OSMA_TrailingProfitMethod = 1; // Trail profit method
int OSMA_Period_Fast = 8; // Period Fast
int OSMA_Period_Slow = 6; // Period Slow
int OSMA_Period_Signal = 9; // Period for signal
ENUM_APPLIED_PRICE OSMA_Applied_Price = 4; // Applied Price
double OSMA_SignalLevel = -0.2; // Signal level
int OSMA1_SignalMethod = 120; // Signal method for M1 (0-
int OSMA5_SignalMethod = 49; // Signal method for M5 (0-
int OSMA15_SignalMethod = -71; // Signal method for M15 (0-
int OSMA30_SignalMethod = -95; // Signal method for M30 (0-
int OSMA1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int OSMA1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT OSMA1_CloseCondition = C_OSMA_BUY_SELL; // Close condition for M1
int OSMA5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int OSMA5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT OSMA5_CloseCondition = C_OSMA_BUY_SELL; // Close condition for M5
int OSMA15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int OSMA15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT OSMA15_CloseCondition = C_OSMA_BUY_SELL; // Close condition for M15
int OSMA30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int OSMA30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT OSMA30_CloseCondition = C_OSMA_BUY_SELL; // Close condition for M30
double OSMA1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double OSMA5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double OSMA15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double OSMA30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __RSI_Parameters__ = "-- Settings for the Relative Strength Index indicator --"; // >>> RSI <<<
extern uint RSI_Active_Tf = 12; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int RSI_Period_M1 = 32; // Period for M1
extern int RSI_Period_M5 = 2; // Period for M5
extern int RSI_Period_M15 = 2; // Period for M15
extern int RSI_Period_M30 = 2; // Period for M30
extern ENUM_APPLIED_PRICE RSI_Applied_Price = 3; // Applied Price
extern uint RSI_Shift = 0; // Shift
extern ENUM_TRAIL_TYPE RSI_TrailingStopMethod = 6; // Trail stop method
extern ENUM_TRAIL_TYPE RSI_TrailingProfitMethod = 11; // Trail profit method
extern int RSI_SignalLevel = 36; // Signal level (-49-49)
extern int RSI1_SignalMethod = -63; // Signal method for M1 (-63-63)
extern int RSI5_SignalMethod = -61; // Signal method for M5 (-63-63)
extern int RSI15_SignalMethod = -63; // Signal method for M15 (-63-63)
extern int RSI30_SignalMethod = 0; // Signal method for M30 (-63-63)
// bool RSI_DynamicPeriod = False;
int RSI1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int RSI1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT RSI1_CloseCondition = C_RSI_BUY_SELL; // Close condition for M1
int RSI5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int RSI5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT RSI5_CloseCondition = C_RSI_BUY_SELL; // Close condition for M5
int RSI15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int RSI15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT RSI15_CloseCondition = C_RSI_BUY_SELL; // Close condition for M15
int RSI30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int RSI30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT RSI30_CloseCondition = C_RSI_BUY_SELL; // Close condition for M30
double RSI1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double RSI5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double RSI15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double RSI30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __RVI_Parameters__ = "-- Settings for the Relative Vigor Index indicator --"; // >>> RVI <<<
uint RVI_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
uint RVI_Period = 10; // Period
ENUM_TRAIL_TYPE RVI_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE RVI_TrailingProfitMethod = 1; // Trail profit method
int RVI_Shift = 2; // Shift
double RVI_SignalLevel = 0.00000000; // Signal level
int RVI1_SignalMethod = 0; // Signal method for M1 (0-
int RVI5_SignalMethod = 0; // Signal method for M5 (0-
int RVI15_SignalMethod = 0; // Signal method for M15 (0-
int RVI30_SignalMethod = 0; // Signal method for M30 (0-
int RVI1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int RVI1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT RVI1_CloseCondition = C_RVI_BUY_SELL; // Close condition for M1
int RVI5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int RVI5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT RVI5_CloseCondition = C_RVI_BUY_SELL; // Close condition for M5
int RVI15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int RVI15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT RVI15_CloseCondition = C_RVI_BUY_SELL; // Close condition for M15
int RVI30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int RVI30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT RVI30_CloseCondition = C_RVI_BUY_SELL; // Close condition for M30
double RVI1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double RVI5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double RVI15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double RVI30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __SAR_Parameters__ = "-- Settings for the Parabolic Stop and Reverse system indicator --"; // >>> SAR <<<
extern uint SAR_Active_Tf = 8; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern double SAR_Step = 0.05; // Step
extern double SAR_Maximum_Stop = 0.4; // Maximum stop
extern int SAR_Shift = 0; // Shift
extern ENUM_TRAIL_TYPE SAR_TrailingStopMethod = 7; // Trail stop method
extern ENUM_TRAIL_TYPE SAR_TrailingProfitMethod = 11; // Trail profit method
extern double SAR_SignalLevel = 0; // Signal level
extern int SAR1_SignalMethod = 91; // Signal method for M1 (-127-127)
extern int SAR5_SignalMethod = 25; // Signal method for M5 (-127-127)
extern int SAR15_SignalMethod = 28; // Signal method for M15 (-127-127)
extern int SAR30_SignalMethod = 2; // Signal method for M30 (-127-127)
int SAR1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int SAR1_OpenCondition2 = 0;   // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT SAR1_CloseCondition = C_SAR_BUY_SELL; // Close condition for M1
int SAR5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int SAR5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT SAR5_CloseCondition = C_SAR_BUY_SELL; // Close condition for M5
int SAR15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int SAR15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT SAR15_CloseCondition = C_SAR_BUY_SELL; // Close condition for M15
int SAR30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int SAR30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT SAR30_CloseCondition = C_SAR_BUY_SELL; // Close condition for M30
double SAR1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double SAR5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double SAR15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double SAR30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __StdDev_Parameters__ = "-- Settings for the Standard Deviation indicator --"; // >>> STDDEV <<<
uint StdDev_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
int StdDev_MA_Period = 10; // Period
int StdDev_MA_Shift = 0; // Shift
ENUM_MA_METHOD StdDev_MA_Method = 1; // MA Method
ENUM_APPLIED_PRICE StdDev_Applied_Price = PRICE_CLOSE; // Applied Price
int StdDev_Shift = 0; // Shift
ENUM_TRAIL_TYPE StdDev_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE StdDev_TrailingProfitMethod = 1; // Trail profit method
double StdDev_SignalLevel = 0.00000000; // Signal level
int StdDev1_SignalMethod = 0; // Signal method for M1 (0-
int StdDev5_SignalMethod = 0; // Signal method for M5 (0-
int StdDev15_SignalMethod = 0; // Signal method for M15 (0-
int StdDev30_SignalMethod = 0; // Signal method for M30 (0-
int StdDev1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int StdDev1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT StdDev1_CloseCondition = C_STDDEV_BUY_SELL; // Close condition for M1
int StdDev5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int StdDev5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT StdDev5_CloseCondition = C_STDDEV_BUY_SELL; // Close condition for M5
int StdDev15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int StdDev15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT StdDev15_CloseCondition = C_STDDEV_BUY_SELL; // Close condition for M15
int StdDev30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int StdDev30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT StdDev30_CloseCondition = C_STDDEV_BUY_SELL; // Close condition for M30
double StdDev1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double StdDev5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double StdDev15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double StdDev30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __Stochastic_Parameters__ = "-- Settings for the Stochastic Oscillator --"; // >>> STOCHASTIC <<<
uint Stochastic_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
uint Stochastic_KPeriod = 5; // K line period
uint Stochastic_DPeriod = 5; // D line period
uint Stochastic_Slowing = 5; // Slowing
ENUM_MA_METHOD Stochastic_MA_Method = MODE_SMA; // Moving Average method
ENUM_STO_PRICE Stochastic_Price_Field = 0; // Price (0 - Low/High or 1 - Close/Close)
uint Stochastic_Shift = 0; // Shift (relative to the current bar)
ENUM_TRAIL_TYPE Stochastic_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE Stochastic_TrailingProfitMethod = 1; // Trail profit method
double Stochastic_SignalLevel = 0.00000000; // Signal level
int Stochastic1_SignalMethod = 0; // Signal method for M1 (0-
int Stochastic5_SignalMethod = 0; // Signal method for M5 (0-
int Stochastic15_SignalMethod = 0; // Signal method for M15 (0-
int Stochastic30_SignalMethod = 0; // Signal method for M30 (0-
int Stochastic1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int Stochastic1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT Stochastic1_CloseCondition = C_STOCHASTIC_BUY_SELL; // Close condition for M1
int Stochastic5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int Stochastic5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT Stochastic5_CloseCondition = C_STOCHASTIC_BUY_SELL; // Close condition for M5
int Stochastic15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int Stochastic15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT Stochastic15_CloseCondition = C_STOCHASTIC_BUY_SELL; // Close condition for M15
int Stochastic30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int Stochastic30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT Stochastic30_CloseCondition = C_STOCHASTIC_BUY_SELL; // Close condition for M30
double Stochastic1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double Stochastic5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double Stochastic15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double Stochastic30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __WPR_Parameters__ = "-- Settings for the Larry Williams' Percent Range indicator --"; // >>> WPR <<<
extern uint WPR_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
extern int WPR_Period_M1 = 11; // Period for M1
extern int WPR_Period_M5 = 5; // Period for M5
extern int WPR_Period_M15 = 5; // Period for M15
extern int WPR_Period_M30 = 8; // Period for M30
extern int WPR_Shift = 0; // Shift
extern int WPR_SignalLevel = 20; // Signal level
extern ENUM_TRAIL_TYPE WPR_TrailingStopMethod = 22; // Trail stop method
extern ENUM_TRAIL_TYPE WPR_TrailingProfitMethod = 11; // Trail profit method
extern int WPR1_SignalMethod = -46; // Signal method for M1 (-63-63)
extern int WPR5_SignalMethod = -40; // Signal method for M5 (-63-63)
extern int WPR15_SignalMethod = -60; // Signal method for M15 (-63-63)
extern int WPR30_SignalMethod = 0; // Signal method for M30 (-63-63)
int WPR1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int WPR1_OpenCondition2 = 0; // Open condition 2 for M1 (0-1023)
ENUM_MARKET_EVENT WPR1_CloseCondition = C_WPR_BUY_SELL; // Close condition for M1
int WPR5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int WPR5_OpenCondition2 = 0; // Open condition 2 for M5 (0-1023)
ENUM_MARKET_EVENT WPR5_CloseCondition = C_WPR_BUY_SELL; // Close condition for M5
int WPR15_OpenCondition1 = 0; // Open condition 1 for M15 (0-1023)
int WPR15_OpenCondition2 = 0; // Open condition 2 for M15 (0-1023)
ENUM_MARKET_EVENT WPR15_CloseCondition = C_WPR_BUY_SELL; // Close condition for M15
int WPR30_OpenCondition1 = 0; // Open condition 1 for M30 (0-1023)
int WPR30_OpenCondition2 = 0; // Open condition 2 for M30 (0-1023)
ENUM_MARKET_EVENT WPR30_CloseCondition = C_WPR_BUY_SELL; // Close condition for M30
double WPR1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double WPR5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double WPR15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double WPR30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
string __ZigZag_Parameters__ = "-- Settings for the ZigZag indicator --"; // >>> ZIGZAG <<<
uint ZigZag_Active_Tf = 0; // Activate timeframes (1-255, e.g. M1=1,M5=2,M15=4,M30=8,H1=16,H2=32...)
uint ZigZag_Depth = 0; // Depth
uint ZigZag_Deviation = 0; // Deviation
uint ZigZag_Backstep = 0; // Deviation
uint ZigZag_Shift = 0; // Shift (relative to the current bar)
ENUM_TRAIL_TYPE ZigZag_TrailingStopMethod = 22; // Trail stop method
ENUM_TRAIL_TYPE ZigZag_TrailingProfitMethod = 1; // Trail profit method
double ZigZag_SignalLevel = 0.00000000; // Signal level
int ZigZag1_SignalMethod = 0; // Signal method for M1 (0-31)
int ZigZag5_SignalMethod = 0; // Signal method for M5 (0-31)
int ZigZag15_SignalMethod = 0; // Signal method for M15 (0-31)
int ZigZag30_SignalMethod = 0; // Signal method for M30 (0-31)
int ZigZag1_OpenCondition1 = 0; // Open condition 1 for M1 (0-1023)
int ZigZag1_OpenCondition2 = 0; // Open condition 2 for M1 (0-)
ENUM_MARKET_EVENT ZigZag1_CloseCondition = C_ZIGZAG_BUY_SELL; // Close condition for M1
int ZigZag5_OpenCondition1 = 0; // Open condition 1 for M5 (0-1023)
int ZigZag5_OpenCondition2 = 0; // Open condition 2 for M5 (0-)
ENUM_MARKET_EVENT ZigZag5_CloseCondition = C_ZIGZAG_BUY_SELL; // Close condition for M5
int ZigZag15_OpenCondition1 = 0; // Open condition 1 for M15 (0-)
int ZigZag15_OpenCondition2 = 0; // Open condition 2 for M15 (0-)
ENUM_MARKET_EVENT ZigZag15_CloseCondition = C_ZIGZAG_BUY_SELL; // Close condition for M15
int ZigZag30_OpenCondition1 = 0; // Open condition 1 for M30 (0-)
int ZigZag30_OpenCondition2 = 0; // Open condition 2 for M30 (0-)
ENUM_MARKET_EVENT ZigZag30_CloseCondition = C_ZIGZAG_BUY_SELL; // Close condition for M30
double ZigZag1_MaxSpread  =  6.0; // Max spread to trade for M1 (pips)
double ZigZag5_MaxSpread  =  7.0; // Max spread to trade for M5 (pips)
double ZigZag15_MaxSpread =  8.0; // Max spread to trade for M15 (pips)
double ZigZag30_MaxSpread = 10.0; // Max spread to trade for M30 (pips)

//+------------------------------------------------------------------+
extern string __Experimental_Parameters__ = "-- Experimental parameters (not safe) --"; // >>> EXPERIMENTAL <<<
// Set stop loss to zero, once the order is profitable.
extern bool MinimalizeLosses = 0; // Minimalize losses?
int HourAfterPeak = 18; // Hour after peak
int ManualGMToffset = 0; // Manual GMT Offset
// How often trailing stop should be updated (in seconds). FIXME: Fix relative delay in backtesting.
int TrailingStopDelay = 0; // Trail stop delay (in secs)
// How often job list should be processed (in seconds).
int JobProcessDelay = 1; // Job process delay (in secs)

// Cache some calculated variables for better performance. FIXME: Needs some work.
#ifdef __experimental__
  extern bool Cache = false; // Cache
#else
  const bool Cache = false; // Cache
#endif

//+------------------------------------------------------------------+
extern string __Logging_Parameters__ = "-- Settings for logging & messages --"; // >>> LOGS & MESSAGES <<<
extern bool WriteReport = 1; // Write summary report on finish
extern bool PrintLogOnChart = 1; // Display info on chart
extern bool VerboseErrors = 1; // Display errors
extern bool VerboseInfo = 1; // Display info messages
#ifdef __debug__
  extern bool VerboseDebug = 0; // Display debug messages
  extern bool VerboseTrace = 0; // Display trace messages
#else
  bool VerboseDebug = 0;
  bool VerboseTrace = 0;
#endif

//+------------------------------------------------------------------+
extern string __UI_UX_Parameters__ = "-- Settings for User Interface & Experience --"; // >>> UI & UX <<<
extern bool SendEmailEachOrder = 0; // Send e-mail per each order
extern color ColorBuy = 16711680; // Color: Buy
extern color ColorSell = 255; // Color: Sell
extern bool SoundAlert = 0; // Enable sound alerts
extern string SoundFileAtOpen = "alert.wav"; // Sound: on order open
extern string SoundFileAtClose = "alert.wav"; // Sound: on order close
// extern bool SendLogs = false; // Send logs to remote host for diagnostic purposes
//+------------------------------------------------------------------+

extern string __Optimization_Parameters__ = "-- Optimization parameters --"; // >>> OPTIMIZATION <<<
#ifdef __optimize__ extern #endif ENUM_TIMEFRAMES TrendPeriod = 30; // Period for trend calculation

extern string __Backtest_Parameters__ = "-- Testing & troubleshooting parameters --"; // >>> TESTING <<<
#ifndef __backtest__
  extern bool ValidateSettings = 0; // Validate startup settings
#else
  extern bool ValidateSettings = 1; // Validate startup settings
#endif
extern bool RecordTicksToCSV = 0; // Record ticks into CSV files
extern int AccountConditionToDisable = 0; // Override: Disable specific n action
extern bool DisableCloseConditions = 0; // Override: Disable all close conditions
// extern int DemoMarketStopLevel = 10; // Demo market stop level

//+------------------------------------------------------------------+
extern string __EA_Constants__ = "-- Constants --"; // >>> CONSTANTS <<<
extern int MagicNumber = 31337; // Unique EA magic number (+40)

//+------------------------------------------------------------------+
extern string __Other_Parameters__ = "-- Other parameters --"; // >>> OTHER <<<
