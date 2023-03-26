let _validatePreimage;

async function lnurlPay(lnAddress, amount, message, callback) {
    try {
        const { invoice, params, successAction, validatePreimage } =
            await LnurlPay.requestInvoice({
                lnUrlOrAddress: lnAddress,
                tokens: amount,
                comment: message,
            });

        _validatePreimage = validatePreimage;
        callback(invoice);
    } catch (error) {
        console.error(error);
        alert('Error: ' + error.message);
    }
}

async function sendPayment(invoice) {
    try {
        if (window.webln) {
            await webln.enable();

            const payResponse = await webln.sendPayment(invoice);

            if (_validatePreimage(payResponse.preimage)) {
                alert("yay, paid!");
            } else {
                alert("fail");
            }
        } else {
            alert("No webln enabled");
        }
    } catch (error) {
        console.error(error);
        alert('Error: ' + error.message);
    }
}