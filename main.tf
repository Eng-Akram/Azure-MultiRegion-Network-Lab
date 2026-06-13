# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# 1. Resource Group
resource "azurerm_resource_group" "network_rg" {
  name     = "AZ700-Network-RG"
  location = "eastus"
}

# ==================== EAST US: CORE SERVICES ====================
resource "azurerm_virtual_network" "core_vnet" {
  name                = "CoreServicesVNet"
  address_space       = ["10.1.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_subnet" "shared_services" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "database" {
  name                 = "DatabaseSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "web_services" {
  name                 = "PublicWebServiceSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = ["10.1.3.0/24"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = ["10.1.0.0/27"] # Standard for gateway subnets
}

# ==================== WEST EUROPE: MANUFACTURING ====================
resource "azurerm_virtual_network" "mfg_vnet" {
  name                = "ManufacturingVNet"
  address_space       = ["10.2.0.0/16"]
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_subnet" "mfg_systems" {
  name                 = "ManufacturingSystemsSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.mfg_vnet.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "sensor_1" {
  name                 = "SensorsSubnet1"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.mfg_vnet.name
  address_prefixes     = ["10.2.2.0/24"]
}

# ==================== SOUTHEAST ASIA: RESEARCH ====================
resource "azurerm_virtual_network" "research_vnet" {
  name                = "ResearchVNet"
  address_space       = ["10.3.0.0/16"]
  location            = "southeastasia"
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_subnet" "research_system" {
  name                 = "ResearchSystemSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.research_vnet.name
  address_prefixes     = ["10.3.1.0/24"]
}