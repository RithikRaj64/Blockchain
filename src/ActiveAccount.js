import React, { useState, useEffect } from 'react';
import Web3 from 'web3';

function ActiveAccount() {

    const [account, setAccount] = useState("");

    useEffect(() => {

        async function fetchAccount() {
            const web3 = new Web3(Web3.givenProvider || "http://localhost:7545");
            const accounts = await web3.eth.requestAccounts()
            setAccount(accounts[0]);
        }

        fetchAccount();
    }, []);

    return (
        <h1>Your Account is {account}</h1>
    );
}

export default ActiveAccount;