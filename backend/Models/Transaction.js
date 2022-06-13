const mongoose = require('mongoose');

const transaction = new mongoose.Schema({
  user: {
    type: mongoose.Schema.ObjectId,
    ref: 'users'
  },
  description: {
    type: String
  },
  coinAmount: {
    type: Number
  },
  usdAmount: {
    type: Number
  },
  type: {
    type: String
  },
  coin: {
    type: String
  },
  coinPrice: {
    type: Number
  },
  acountBalanceUSD: {
    type: Number
  },
  acountBalanceCOIN: {
    type: Number
  },
},{timestamps:true})

const Transaction = mongoose.model('transactions', transaction);
module.exports = Transaction