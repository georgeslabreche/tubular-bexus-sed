// Define constants for range and cell locations.
var COLUMN_RANGE_SPONSOR = 'K5:K197';
var COLUMN_RANGE_COST = 'J5:J197';

var CELL_SPONSOR_SHIPPING = 'K200';
var CELL_SPONSOR_ERROR_MARGIN = 'K201';

var CELL_SHIPPING_COST_PERCENTAGE = 'F209';
var CELL_ERROR_MARGIN_PERCENTAGE = 'F210';

var CELL_SHIPPING_COST = 'F226';
var CELL_ERROR_MARGIN_COST = 'F227';

// Mapping between sponsors and the total allocated funds cell
var SPONSORS_TOTAL_ALLOCATION_CELL_DICT = {
  'LTU': 'G215',
  'SNSB': 'G216',
  'FMI': 'G217',
  'RESTEK': 'G218',
  'TEKNOLAB': 'G219',
  'SMC': 'G220',
  'PARKER': 'G221'};

// Sheet and ranges.
var sheet = SpreadsheetApp.getActiveSpreadsheet();
var rangeSponsor = sheet.getRange(COLUMN_RANGE_SPONSOR);
var rangeCost = sheet.getRange(COLUMN_RANGE_COST);

/**
 * Iterator through all the item/coponent rows in the budget table
 * and sum to total cost sponsored by a given sponser.
 */
function calculateSponsorBudgetAllocation_(sponsor) {
 
  var numRows = rangeSponsor.getNumRows();
  var totalAmountSponsored = 0;
  
  for (var i = 1; i <= numRows; i++) {
    var componentSponsor = rangeSponsor.getCell(i,1).getValue();
    if(componentSponsor == sponsor){
      var amountSponsored = rangeCost.getCell(i,1).getValue();
      totalAmountSponsored = totalAmountSponsored + amountSponsored;
    }
  }
  
  var cell = sheet.getRange(SPONSORS_TOTAL_ALLOCATION_CELL_DICT[sponsor]); 
  cell.setValue(totalAmountSponsored);
  
  return totalAmountSponsored;
}


/**
 * Allocate shipping cost to a given sponsor.
 */
function allocateShippingCostToSponsor_(shippingCost, sponsor){
  var cell = sheet.getRange(CELL_SPONSOR_SHIPPING); 
  cell.setValue(sponsor);
  
  allocateExtraCostToSponsor_(shippingCost, sponsor)
}

/**
 * Allocate error margin cost to a given sponsor.
 */
function allocateErrorMarginCostToSponsor_(errorMarginCost, sponsor){
  var cell = sheet.getRange(CELL_SPONSOR_ERROR_MARGIN); 
  cell.setValue(sponsor);
  
  allocateExtraCostToSponsor_(errorMarginCost, sponsor)
}

/**
 * Allocate extra cost to a given sponsor.
 */
function allocateExtraCostToSponsor_(extraCost, sponsor){
  var costAllocatedToSponsorCell = sheet.getRange(SPONSORS_TOTAL_ALLOCATION_CELL_DICT[sponsor]); 
  costAllocatedToSponsorCell.setValue(costAllocatedToSponsorCell.getValue() + extraCost);
}


/**
 * Calculate sponsorship allocation of funds for all sponsors.
 */
function calculateAllSponsorBudgetAllocations(){
  var amountLTU = calculateSponsorBudgetAllocation_('LTU');
  var amountSNSB = calculateSponsorBudgetAllocation_('SNSB');
  var amountFMI = calculateSponsorBudgetAllocation_('FMI');
  var amountRESTEK = calculateSponsorBudgetAllocation_('RESTEK');
  var amountTEKNOLAB = calculateSponsorBudgetAllocation_('TEKNOLAB');
  var amountSMC = calculateSponsorBudgetAllocation_('SMC');
  var amountPARKER = calculateSponsorBudgetAllocation_('PARKER');
  
  // Calculate error margin.
  // Error margin only applies to components purchased with LTU and SNSB funds.
  // This is because other sponsorships are not based on funds but on components donated.
  var errorMarginPercentage = sheet.getRange(CELL_ERROR_MARGIN_PERCENTAGE).getValue(); 
  var errorMarginCost = errorMarginPercentage * (amountLTU + amountSNSB);
  var cell = sheet.getRange(CELL_ERROR_MARGIN_COST); 
  cell.setValue(errorMarginCost);
  
  // Calculate shipping cost.
  // Treat the shipping cost the same way as error margin.
  // only applies to components purchased with LTU and SNSB funds.
  var shippingCostPercentage = sheet.getRange(CELL_SHIPPING_COST_PERCENTAGE).getValue(); 
  var shippingCost = shippingCostPercentage * (amountLTU + amountSNSB);
  var cell = sheet.getRange(CELL_SHIPPING_COST); 
  cell.setValue(shippingCost);
  
  // Allocate shipping and error costs to specific sponsor.
  allocateShippingCostToSponsor_(shippingCost, 'SNSB');
  allocateErrorMarginCostToSponsor_(errorMarginCost, 'SNSB');
}

