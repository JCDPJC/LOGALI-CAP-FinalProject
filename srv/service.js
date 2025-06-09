// const cds = require("@sap.cds");   //Variable cds
// const { SalesOrders } = cds.entities("com.capjcd");   // Leo las entidades del contexto

// module.export = (srv) => {

//     console.log("En el código");

//     srv.before("CREATE", SalesOrders, (req) => {
// 		req.data.CreateOn = new Date().toISOString().slice(0,10);  //Only YYYY-MM-DD
// 		return req;
// 	});

// };

const cds = require('@sap/cds');

module.exports = class SalesOrderCAP extends cds.ApplicationService {

   

    async init () {
        const {SalesOrders} = this.entities;

        this.before("NEW", SalesOrders.drafts, (req) => {
            req.data.createon = new Date().toISOString().slice(0,10);  //Only YYYY-MM-DD
            req.data.orderstatus = 'Open';
           // return req;
        });

        return super.init();
    }

}