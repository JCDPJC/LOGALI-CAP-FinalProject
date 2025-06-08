namespace com.capjcd;
/*  */
// Aspects
using {
    cuid, // key ID  : UUID;
    managed,
    sap.common.CodeList,
    sap.common.Currencies
} from '@sap/cds/common';

// Types


// Entities -------------------------------------------

// SALES ORDER HEADER
entity SalesOrders : cuid, managed {
    email        : String(30);
    firstname    : String(30);
    lastname     : String(30);
    country      : String(30);
    createon     : Date;
    deliverydate : Date;
    orderstatus  : Association to OrderStatus; //orderstatus --- orderstatus_code
    imageURL     : LargeBinary  @Core.MediaType: imageType  @UI.IsImage; //Image type in field imageType, field is an Image
    imageType    : String       @Core.IsMediaType;
    toSalesItems      : Composition of many SalesItems  // 1..n relation of composition - Deep Insert
                 on toSalesItems.salesorder = $self; // 1..N relation
}

entity SalesItems : cuid {
    name             : String(40);
    description      : String(40);
    releasedate      : Date;
    discontinueddate : Date;
    price            : Decimal(12, 2);
    currency         : Association to Currencies; // 1..1 relation, currency_code
    height           : Decimal(15, 3);
    width            : Decimal(15, 3);
    depth            : Decimal(15, 3);
    baseUnit         : String default 'CM';
    quantity         : Decimal(16, 2);
    quanunit         : String default 'UN';
    salesorder       : Association to SalesOrders;
};

/** Code List  -------------------------------------------- */
// ORDER STATUS
entity OrderStatus : CodeList {
    key code        : String(20) enum {
            Open = 'Open';
            Accepted = 'Accepted ';
            Rejected = 'Rejected';
        };
        criticality : Integer; //Store Criticality of code
};

/** Value Helps */
// CURRENCIES
entity sap.common.Currencies : CodeList {
    key code      : String(3); //> ISO 4217 alpha-3 codes
        symbol    : String(5); //> for example, $, €, £, ₪, ...
        minorUnit : Int16; //> for example, 0 or 2
};


