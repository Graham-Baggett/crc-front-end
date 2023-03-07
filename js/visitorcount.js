(async function () {
  try {
    const putResponse = await fetch(
      "https://ufh573r6ol.execute-api.us-east-1.amazonaws.com/Prod/put"
    );
    if (!putResponse.ok) {
      throw new Error("Failed to update visitor count");
    }

    const getResponse = await fetch(
      "https://ufh573r6ol.execute-api.us-east-1.amazonaws.com/Prod/get"
    );
    if (!getResponse.ok) {
      throw new Error("Failed to get visitor count");
    }

    const data = await getResponse.json();
    const visitorCount = document.getElementById("visitorcount");
    visitorCount.innerText = data;
  } catch (error) {
    console.error(error);
    // Handle the error appropriately
  }
})();
