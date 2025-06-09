sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'salesorders/test/integration/FirstJourney',
		'salesorders/test/integration/pages/SalesOrdersList',
		'salesorders/test/integration/pages/SalesOrdersObjectPage',
		'salesorders/test/integration/pages/SalesItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SalesOrdersList, SalesOrdersObjectPage, SalesItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('salesorders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSalesOrdersList: SalesOrdersList,
					onTheSalesOrdersObjectPage: SalesOrdersObjectPage,
					onTheSalesItemsObjectPage: SalesItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);