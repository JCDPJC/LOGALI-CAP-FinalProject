using {SalesOrderCAP as service} from '../service';

annotate service.SalesItems with {
    name             @title            : '{i18n>name}'; //@Common.FieldControl: #ReadOnly;
    description      @title            : '{i18n>description}';
    releasedate      @title            : '{i18n>releasedate}';
    discontinueddate @title            : '{i18n>discontinueddate}';
    price            @title: '{i18n>price}'     @Measures.ISOCurrency: currency_code; //
    currency         @Common.IsCurrency: true;
    height           @title: '{i18n>height}'    @Measures.Unit       : baseUnit;
    width            @title: '{i18n>width}'     @Measures.Unit       : baseUnit;
    depth            @title: '{i18n>depth}'     @Measures.Unit       : baseUnit;
    baseUnit         @Common.IsUnit      @Common.FieldControl : #ReadOnly;
    quantity         @title: '{i18n>quantity}'  @Measures.Unit       : quanunit;
    quanunit         @Common.IsUnit      @Common.FieldControl : #ReadOnly;
};

annotate service.SalesItems with @(
    
    UI.HeaderInfo     : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>item}',
        TypeNamePlural: '{i18n>items}',
        Title         : {
            $Type: 'UI.DataField',
            Value: name
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: description
        }
    },

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Value: description
        },
        {
            $Type: 'UI.DataField',
            Value: price
        },
        {
            $Type: 'UI.DataField',
            Value: quantity
        },
        {
            $Type: 'UI.DataField',
            Value: releasedate
        }

    ],


    UI.FieldGroup #ItemDetail    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: description
            },
            {
                $Type: 'UI.DataField',
                Value: releasedate
            },
            {
                $Type: 'UI.DataField',
                Value: discontinueddate
            },
            {
                $Type: 'UI.DataField',
                Value: price
            },
            {
                $Type: 'UI.DataField',
                Value: quantity
            }
        ]
    },

    UI.FieldGroup #ItemMeasure    : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: height
            },
            {
                $Type: 'UI.DataField',
                Value: width
            },
            {
                $Type: 'UI.DataField',
                Value: depth
            }
            
        ]
    },    

    UI.Facets         : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#ItemDetail',
        Label : '{i18n>itemdetails}',
        ID    : 'ItemDetail'
    },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#ItemMeasure',
            Label : '{i18n>measures}',
            ID    : 'measures'
        }]
);