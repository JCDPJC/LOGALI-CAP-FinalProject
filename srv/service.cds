using {com.capjcd as entities} from '../db/squema'; //The squema path

service SalesOrderCAP {
   entity SalesOrders as
      select from entities.SalesOrders {
         ID,
         email    @mandatory,
         firstname,
         lastname,
         country,
         createon @readonly,
         deliverydate,
         orderstatus,
         imageURL,
         imageType,
         toSalesItems,
         
      };

   entity SalesItems  as
      select from entities.SalesItems {
         *,
         height   @(assert.range: [
            0.000,
            999.999
         ]),
         width    @(assert.range: [
            0.000,
            999.999
         ]),
         depth    @(assert.range: [
            0.000,
            199.999
         ]),
         baseUnit,
         quantity @(assert.range: [
            0.00,
            9999.00
         ]),
         quanunit,
         tosalesorder,
      };

   /**Code List */
   entity OrderStatus as projection on entities.OrderStatus;
}
