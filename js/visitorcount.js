fetch('https://thmc67kpn2.execute-api.us-east-1.amazonaws.com/prod/put')
    .then(() => fetch('https://thmc67kpn2.execute-api.us-east-1.amazonaws.com/prod/get'))
    .then(response => response.json())
    .then((data) => {
                        document.getElementById('visitorcount').innerText = data
                    }
     )