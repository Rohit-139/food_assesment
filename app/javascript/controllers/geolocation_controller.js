import { Controller } from "@hotwired/stimulus"

  const options = {
  enableHighAccuracy: true,
  timeout: 10000,
  maximumAge: 0,
};

export default class extends Controller {
   static targets = ["error"]
  connect() {
    console.log("stimulus")
  }



 success(pos) {
  const crd = pos.coords;

  console.log("Your current position is:");
  console.log(`Latitude : ${crd.latitude}`);
  console.log(`Longitude: ${crd.longitude}`);
  console.log(`More or less ${crd.accuracy} meters.`);
  this.sendLocationToOrders(crd.latitude, crd.longitude);
}

 error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

search(){
navigator.geolocation.getCurrentPosition(
  (pos) => this.success(pos),
  (err) => this.error(err),
  options);
}


  async sendLocationToOrders(latitude, longitude) {
    const data = { latitude: latitude, longitude: longitude };

    try {
      const csrfToken = document.querySelector("meta[name='csrf-token']").content;
      
      const response = await fetch("/orders/preview", { 
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify(data)
      });

      if (response.ok) {
        const result = await response.json();
        console.log("Location sent successfully, response:", result);
        window.location.href = result.redirect_url
        
      } else {
        console.error("Error sending location:", response.statusText);
      }
    } catch (error) {
      console.error("Network error:", error);
    }
  }
}


