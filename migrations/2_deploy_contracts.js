const $CONTRACT1 = artifacts.require("$CONTRACT1");
const $CONTRACT2 = artifacts.require("$CONTRACT2");

module.exports = function (deployer) {
  deployer.deploy($CONTRACT1);
  deployer.link($CONTRACT1, $CONTRACT2);
  deployer.deploy($CONTRACT2);
};
