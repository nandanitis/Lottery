const Lottery = artifacts.require("./Lottery.sol");

contract("Lottery", accounts => {

  let contract;
  before( async() => {
    contract = await Lottery.deployed();
  })

   it("..should get deployed", async () => {
    assert.notEqual(contract,"Contract is Empty");
    let owner = await contract.owner();
    console.log(owner);
  });

  






});
