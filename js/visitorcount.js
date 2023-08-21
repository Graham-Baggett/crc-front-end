(async function () {
  try {
    const sequenceResponse = await fetch(
      "https://grahambaggett.net:8443/sequence"
    );
    if (!sequenceResponse.ok) {
      throw new Error("Failed to get visitor count");
    }

    const responseData = await sequenceResponse.json();
    const sequenceNumber = responseData.sequence_number;
    const visitorCount = document.getElementById("visitorcount");
    visitorCount.innerText = sequenceNumber.toString();
  } catch (error) {
    console.error(error);
  }
})();
