using {com.capjcd as entities} from '../db/squema'; //The squema path

service SalesOrderCAP {
   entity SalesOrders         as projection on entities.SalesOrders;
   entity SalesItems         as projection on entities.SalesItems;

   /**Code List */
    entity OrderStatus           as projection on entities.OrderStatus;
}