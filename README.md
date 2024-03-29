## 🌟 **Open to Work** 🌟

Hello there! 👋

If you or your team are working on projects similar to the ones you find in this GitHub repository, I'm open to collaboration and excited to contribute my skills as a developer.

I have a deep passion for developing mobile apps, and I'm eager to work on innovative and challenging tasks. You can find my resume [here](https://drive.google.com/file/d/12qOmW2rQDDKn3IwK25qbcDcJSc0GpV1W/view), which provides more details about my experience and qualifications.

If you see potential for collaboration or would like to discuss how I can contribute to your projects, please feel free to reach out to me at [aaa.software.dev@gmail.com](mailto:aaa.software.dev@gmail.com?subject=Job%20Opportunity&body=Hello,%0D%0A%0D%0AI%20am%20contacting%20you%20in%20response%20to%20your%20website%20and%20to%20inquire%20about%20your%20availability%20for%20a%20potential%20job%20opportunity%20as%20a%20software%20developer.%0D%0A%0D%0APlease%20let%20me%20know%20if%20you%20are%20interested%20in%20discussing%20further.%0D%0A%0D%0AThank%20you,%0D%0A[Your%20Name]%0D%0A[Your%20Contact%20Information]).

Thank you for taking the time to visit my repository. I look forward to potential opportunities to work together and create something amazing!

---

<div align="center">
    <img src="web/icons/maskable_icon_x192.png?raw=true" width="80px" alt="Personal Bitcoin Tip Card"/>
    <h1> Personal Bitcoin Tip Card </h1>
</div>

<h3 align="center"> A Personal Bitcoin Tip Card created using Flutter Web and BTCPay API! 🚀 </h3>


## Screens Specification

![](screenshot/ss1.png)

Here's how it works: when someone clicks the Tip Bitcoin button, they'll be taken to a tipping form where they can enter the amount, their name, and a message. The form then generates an invoice using the BTCPay API, which the user can pay using their Bitcoin wallet.

![](screenshot/ss2.png)

One of the best things about this project is that it follows the best practices for generating invoices securely. For example, the XPUB is stored only on the BTCPay API server in watch-only mode, which means that an infinite number of Bitcoin addresses can be generated for receiving tips while keeping everything secure.

## Update [27-03-2023]
The Personal Bitcoin Tip Card now includes support for Lightning Network (LN) tips, which have been implemented using LNURLPay and WebLN methods. To receive LN tips, users will need to update the "**lud16**" field in their identity.json file [here](https://github.com/aniketambore/personal-bitcoin-tip-card/blob/main/identity.json#L31) with their Bitcoin Lightning Address.

![](screenshot/ss3.png)

![](screenshot/ss4.png)

If you're interested in setting up your own Personal Bitcoin Tip Card, check out this blog article for more information. Let me know if you have any questions or feedback!

## Contributing:

 - Fork it!
 - Create your feature branch: `git checkout -b my-new-feature`
 - Commit your changes: `git commit -am 'Add some feature'`
 - Push to the branch: `git push origin my-new-feature`
 - Submit a pull request.

 <h3 align="center">Show some ❤ and star the repo to support the project</h3>
