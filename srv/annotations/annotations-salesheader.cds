using {SalesOrderCAP as service} from '../service';
using from './annotations-salesitem.cds';
using from './annotations-orderstatus.cds';


// Draft enabled
annotate service.SalesOrders with @odata.draft.enabled;

annotate service.SalesOrders with { //Field Labels with @title

    email        @title: '{i18n>Email}';
    firstname    @title: 'First Name';
    lastname     @title: 'Last Name';
    country      @title: 'Country';
    createon     @title: 'Create On';
    deliverydate @title: 'Delivery Date';
    orderstatus  @title: 'Status';
    imageURL     @title: 'Image';
    toSalesItems

};

annotate service.SalesOrders with {
    orderstatus @Common: { //Status text instead code
        Text           : orderstatus.name, // Use association
        TextArrangement: #TextOnly
    };
};


annotate service.SalesOrders with @(

    UI.HeaderInfo         : { //Header Info
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Sales Order',
        TypeNamePlural: 'Sales Orders',
        Title         : {
            $Type: 'UI.DataField',
            Value: lastname
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: firstname
        }
    },

    // Filtros
    UI.SelectionFields    : [
        firstname,
        lastname,
        email,
        orderstatus_code,
        deliverydate
    ],

    UI.LineItem           : [ //Annotation Line Item
        {
            $Type                : 'UI.DataField',
            Value                : imageURL, //The image
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            }
        },
        {
            $Type: 'UI.DataField',
            //Fielld Type
            Value: email // Field Name for the annotation
        },
        {
            $Type: 'UI.DataField',
            Value: firstname
        },
        {
            $Type: 'UI.DataField',
            Value: lastname
        },
        {
            $Type: 'UI.DataField',
            Value: deliverydate
        },
        {
            $Type                : 'UI.DataField',
            Value                : orderstatus_code,
            Criticality          : orderstatus.criticality, //Origin of Criticality
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            }
        },
        {
            $Type: 'UI.DataField',
            Value: country
        }
    ],

    UI.FieldGroup #Image  : { //For the image
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: imageURL,
            Label: ''
        }],
    },

    // Fieldgroup for Header Facets
    UI.FieldGroup #HeaderA: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: firstname
            },
            {
                $Type: 'UI.DataField',
                Value: lastname,
            },
            {
                $Type: 'UI.DataField',
                Value: email
            }
        ]
    },

    UI.FieldGroup #Details: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: country
            },
            {
                $Type: 'UI.DataField',
                Value: createon,
            },
            {
                $Type: 'UI.DataField',
                Value: deliverydate
            }
        ]
    },

    UI.FieldGroup #Status : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type      : 'UI.DataField',
            Value      : orderstatus_code,
            Criticality: orderstatus.criticality,
            Label      : '',
        // ![@Common.FieldControl]: {$edmJson: {$If: [ //Expresión dinámica
        //     {$Eq: [
        //         {$Path: 'IsActiveEntity'},
        //         false
        //     ]},
        //     1,
        //     //ReadOnly
        //     3 //Optional
        // ]}},
        }]
    },

    // Header Facets
    UI.HeaderFacets       : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Image',
            ID    : 'Image'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Status',
            ID    : 'ProductStatu',
            Label : 'Order Status'
        }
    ],

    // Facet detail with FacetCollections
    UI.Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderA',
            ID    : 'Header',
            Label : 'Header'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Details',
            Label : 'Details',
            ID    : 'HeaderDetails'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'toSalesItems/@UI.LineItem',
            Label : 'Items',
            ID    : 'toInventories'
        }
    ]


);
