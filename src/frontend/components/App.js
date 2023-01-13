import { ethers } from 'ethers';
import React, { useState } from 'react';
import './App.css';

function App() {

  const [account, setAccount] = useState(null);

  const web3 = async () => {
    // Get the accounts given by the Metamask extension into the Browser Window Object
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    setAccount(accounts[0]);

    // Get the Ethereum Provider returned by the Metamask extension 
    const provider = new ethers.providers.Web3Provider(window.ethereum);

    // Get the signer

    // A Signer in ethers is an abstraction of an Ethereum Account
    // which can be used to sign messages and transactions and 
    // send signed transactions to the Ethereum Network to execute state changing operations

    const signer = provider.getSigner();
  }

  return (
    <div>
      <button onClick={web3}>Connect</button>
      <h1>{account}</h1>
    </div>
  );
}

export default App;
