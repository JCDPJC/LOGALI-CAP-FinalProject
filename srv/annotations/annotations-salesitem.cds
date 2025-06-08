using {SalesOrderCAP as service} from '../service';

annotate service.SalesItems with {
    name             @title            : 'Name'; //@Common.FieldControl: #ReadOnly;
    description      @title            : 'Description';
    releasedate      @title            : 'Release Date';
    discontinueddate @title            : 'Discontinued Date';
    price            @title: 'Price'     @Measures.ISOCurrency: currency_code; //
    currency         @Common.IsCurrency: true;
    height           @title: 'Height'    @Measures.Unit       : baseUnit;
    width            @title: 'Width'     @Measures.Unit       : baseUnit;
    depth            @title: 'Depth'     @Measures.Unit       : baseUnit;
    baseUnit         @Common.IsUnit      @Common.FieldControl : #ReadOnly;
    quantity         @title: 'Quantity'  @Measures.Unit       : quanunit;
    quanunit         @Common.IsUnit      @Common.FieldControl : #ReadOnly;
};

annotate service.SalesItems with @(
    
    UI.HeaderInfo     : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Item',
        TypeNamePlural: 'Items',
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
        Label : 'Item Detail',
        ID    : 'ItemDetail'
    },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#ItemMeasure',
            Label : 'Measures',
            ID    : 'measures'
        }]
);