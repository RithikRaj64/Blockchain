import { ethers } from 'ethers';
import React, { useState, useEffect } from 'react';
import './App.css';

function App() {

  const [account, setAccount] = useState(null);
  const [balance, setBalance] = useState("");
  const [conn, setConn] = useState(false);

  const web3 = async () => {
    // Get the accounts given by the Metamask extension into the Browser Window Object
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    setAccount(accounts[0]);

    // Get the Ethereum Provider returned by the Metamask extension 
    const provider = new ethers.providers.Web3Provider(window.ethereum);

    // Get the signer of the first account

    // A Signer in ethers is an abstraction of an Ethereum Account
    // which can be used to sign messages and transactions and 
    // send signed transactions to the Ethereum Network to execute state changing operations

    const signer = provider.getSigner();

    // Other way to get the account
    console.log(await signer.getAddress());

    // Getting balance of the account
    const bal = ((await signer.getBalance()).toString());
    setBalance(ethers.utils.formatEther(bal));

    // Changing the account info
    setConn(true);
  }

  // useEffect(() => {
  //   setInterval(async () => {
  //     const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });

  //     if (!(`${accounts[0]}` === `${account}`)) {
  //       web3();
  //     }
  //   }, 1000)
  // }, []);

  return (
    <div>
      <button onClick={web3}>{(conn) ? "Change Account" : "Connect"}</button>
      <h1>Account Address : {account}</h1>
      <h1>Balance : {balance} ETH</h1>
    </div>
  );
}

export default App;
