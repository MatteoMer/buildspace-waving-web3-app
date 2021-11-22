const main = async () => {
    const [deployer] = await hre.ethers.getSigners();
    const accountBalance = await deployer.getBalance();
  
    console.log('Deploying contracts with account: ', deployer.address);
    console.log('Account balance: ', accountBalance.toString());
  
    const contract = await hre.ethers.getContractFactory('WavePortal');
    const wavePortal = await contract.deploy({
      value: hre.ethers.utils.parseEther('0.001'),
    });
    await wavePortal.deployed();
  
    console.log('WavePortal address: ', wavePortal.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.error(error);
      process.exit(1);
    }
  };
  
  runMain();