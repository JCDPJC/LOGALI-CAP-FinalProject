using {SalesOrderCAP as service} from '../service';
using from './annotations-salesitem.cds';
using from './annotations-orderstatus.cds';


// Draft enabled
annotate service.SalesOrders with @odata.draft.enabled;

annotate service.SalesOrders with { //Field Labels with @title

    email        @title: '{i18n>email}';
    firstname    @title: '{i18n>firstname}';
    lastname     @title: '{i18n>lastname}';
    country      @title: '{i18n>country}';
    createon     @title: '{i18n>createon}';
    deliverydate @title: '{i18n>deliverydate}';
    orderstatus  @title: '{i18n>status}';
    imageURL     @title: '{i18n>image}';
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
        TypeName      : '{i18n>salesorder}',
        TypeNamePlural: '{i18n>salesorders}',
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
            },
            {
                $Type      : 'UI.DataField',
                Value      : orderstatus_code,
                Criticality: orderstatus.criticality,
                Label      : '{i18n>status}'
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
            Label      : ''
        }]
    },

    // Header Facets
    UI.HeaderFacets       : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Image',
            ID    : 'Image'
        }
        // ,
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Target: '@UI.FieldGroup#Status',
        //     ID    : 'ProductStatu',
        //     Label : '{i18n>orderstatus}'
        // }
    ],

    // Facet detail with FacetCollections
    UI.Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderA',
            ID    : 'Header',
            Label : '{i18n>header}'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Details',
            Label : '{i18n>details}',
            ID    : 'HeaderDetails'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'toSalesItems/@UI.LineItem',
            Label : '{i18n>items}',
            ID    : 'toSalesItems'
        }
    ]


);
