import { LightningElement } from "lwc";

export default class VaccineSlotFinder extends LightningElement {
  centers = [];
  dates = [];

  pincodeChangeHandler(e) {
    const pinCode = e.target.value;
    const isEnterKey = e.keyCode === 13;
    if (pinCode.length === 6 && isEnterKey) {
      const today = new Date();
      const formattedDate = '${today.getDate()}-${today.getMonth() + 1}-${today.getFullYear()}';
      //const endpoint = 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=${pinCode}&date=${formattedDate}';
      const endpoint ='https://choudharymanish8585.github.io/cowin-api-sample-response/db.json';
      this.fetchVaccineSlots(endpoint);
    }
  }

  async fetchVaccineSlots(endpoint) {
    alert(1);
    const vaccineSlotRes = await fetch(endpoint);
    alert(2);
    const slotsData = await vaccineSlotRes.json();
    alert('web'+vaccineSlotRes);
     
    this.buildColumnsAndRows(slotsData.centers);
  }

  buildColumnsAndRows(data) {
    // build columns/dates
    const dates = new Map();
    dates.set("name", {
      label: "Center Name",
      fieldName: "name",
      type: "text",
      wrapText: true
    });

    // build rows/centers
    const centers = new Map();

    for (const center of data) {
      !centers.has(center.center_id) &&
        centers.set(center.center_id, { name: center.name });

      for (const session of center.sessions) {
        // destructuring syntax
        const { date, available_capacity, min_age_limit } = session;

        // add date as column in dates map
        dates.set(date, {
          label: date,
          fieldName: date,
          type: "text",
          wrapText: true,
          cellAttributes: { class: { fieldName: "className" } }
        });

        // add column value for the row
        centers.get(center.center_id)[
          date
        ] = `Available Capacity: ${available_capacity}
        Min Age: ${min_age_limit}`;

        centers.get(center.center_id).className =
          available_capacity > 0
            ? "slds-text-color_success"
            : "slds-text-color_error";
      }
    }
    this.dates = Array.from(dates.values());
    this.centers = Array.from(centers.values());
  }

  get hideMessage() {
    return this.centers.length > 0;
  }
}