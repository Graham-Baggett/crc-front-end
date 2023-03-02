fetch("https://ufh573r6ol.execute-api.us-east-1.amazonaws.com/Prod/put")
  .then(() =>
    fetch("https://ufh573r6ol.execute-api.us-east-1.amazonaws.com/Prod/get")
  )
  .then((response) => response.json())
  .then((data) => {
    document.getElementById("visitorcount").innerText = data;
  });
