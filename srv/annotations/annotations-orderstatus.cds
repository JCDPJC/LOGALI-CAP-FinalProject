using {SalesOrderCAP as service} from '../service';

annotate service.OrderStatus with {
    //Field Labels with @title
    code @title : 'Status Name'
         @Common: {
        Text           : name,
        TextArrangement: #TextOnly
    }
};
