const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners()
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal')
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.1'),
    })
    await waveContract.deployed()
    
    console.log(`Yey, this contract is now deployed to: ${waveContract.address} 🎉!`)
    console.log(`This contract deployed by: ${owner.address}`)

    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );

    let waveCount = await waveContract.getTotalWaves()

    let waveTxn = await waveContract.wave('Hey')
    await waveTxn.wait()
    
    waveCount = await waveContract.getTotalWaves()

    waveTxn = await waveContract.wave('Coucou')
    await waveTxn.wait()

    waveCount = await waveContract.getTotalWaves()

    let allWaves = await waveContract.getAllWaves()
    console.log(allWaves)

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );

  }
  
  const runMain = async () => {
    try {
      await main()
      process.exit(0)
    } catch (error) {
      console.log(error)
      process.exit(1)
    }
  }
  
  runMain()