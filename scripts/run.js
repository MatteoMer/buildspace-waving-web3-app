const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners()
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal')
    const waveContract = await waveContractFactory.deploy()
    await waveContract.deployed()
    
    console.log(`Yey, this contract is now deployed to: ${waveContract.address} 🎉!`)
    console.log(`This contract deployed by: ${owner.address}`)

    let waveCount = await waveContract.getTotalWaves()

    let waveTxn = await waveContract.wave()
    await waveTxn.wait()
    
    waveCount = await waveContract.getTotalWaves()

    waveTxn = await waveContract.connect(randomPerson).wave()
    await waveTxn.wait()

    waveCount = await waveContract.getTotalWaves()
    waveCountOfRandomPerson = await waveContract.getTotalWavesByAddress(randomPerson.getAddress())

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