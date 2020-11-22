const mongoose=require('mongoose');




const Schema =new mongoose.Schema({
    email:{
        type:String,
        required:true
    },
    password:{

        type:String,
        required:true
    },
    name:{

        type:String,
        required:true
    },
    contact:{

        type:String,
        required:true
    },
    age:{

        type:Number,
        required:true
    },
    gender:{

        type:String,
        required:true
    }
    ,validEmail:{
        type:Number,
        required:true
    }
    
})
module.exports=mongoose.model('Patient',Schema);