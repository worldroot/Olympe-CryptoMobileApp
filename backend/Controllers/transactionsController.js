const express = require('express');
const jwt_decode = require('jwt-decode');

const Transaction = require('../Models/Transaction');

const { authenticateToken } = require('../utils/jwt');

const route = express.Router();


function getIdFromToken(req) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1];

    const decoded = jwt_decode(token);
    return decoded.id;
}

const index = (req, res, next) => {
    const userId = getIdFromToken(req);

    Transaction.find({ 'user': userId })
        .then(transactions => {
            return res.json(transactions)
        })
        .catch(error => {
            return res.json({
                message: "an error occured when displaying transactions"
            })
        })
}



const addTransaction = (req, res, next) => {

    const userId = getIdFromToken(req);


    let transaction = new Transaction({
        user: userId,
        description: req.body.description,
        coinAmount: req.body.coinAmount,
        usdAmount: req.body.usdAmount,
        type: req.body.type,
        coin: req.body.coin,
        coinPrice: req.body.coinPrice,
        acountBalanceUSD: req.body.acountBalanceUSD,
        acountBalanceCOIN: req.body.acountBalanceCOIN,
    })

    console.log(req.body);
    transaction.save()
        .then(response => {
            res.json({
                message: "transaction Added Successfully"
            })
        })
        .catch(error => {
            res.json({
                message: "an error occured when adding transaction" + error
            })
        })
}


const updateTransaction = (req,res,next) => {

    const userId = getIdFromToken(req);

    
	let updatedTransaction = {
        user: userId,
        description: req.body.description,
        coinAmount: req.body.coinAmount,
        usdAmount: req.body.usdAmount,
        type: req.body.type,
        coin: req.body.coin,
        coinPrice: req.body.coinPrice,
        acountBalanceUSD: req.body.acountBalanceUSD,
        acountBalanceCOIN: req.body.acountBalanceCOIN,
	}
	Transaction.findByIdAndUpdate(req.body.transactionId,{$set: updatedTransaction})
	.then(() => {
		return res.json({
			message: "Transaction updated successfully"
		})
	})
	.catch(error => {
		return res.json({
			message: "an error occured when updating Transaction"
		})
	})
}


//optimize with adding userid in query
const deleteTransaction = (req,res,next) => {
	
	Transaction.findByIdAndRemove(req.params.id)
	.then(() => {
		return res.json({
			message:"Transaction deleted successfully"
		})
	})
	.catch(error =>{
		return res.json({
			message:"an error occured when deleting Transaction"
		})
	})
}



route.get('/', authenticateToken, index)
route.post('/add', authenticateToken, addTransaction)
route.put('/update', authenticateToken, updateTransaction)
route.delete('/delete/:id', authenticateToken, deleteTransaction)



module.exports = route;