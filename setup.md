# How to Deploy Your Personal Bitcoin Tip Card on GitHub Pages

In this blog post, I'll guide you through the setup and deployment process of the "personal-bitcoin-tip-card" project. The process is straightforward if you follow the steps outlined in this post.

To deploy our BTC Pay server, we'll be using third-party hosting. You can refer to this link for more information on deploying the BTCPay server: https://docs.btcpayserver.org/Deployment/ThirdPartyHosting/#third-party-hosting.

First, create a BTCPay server account by heading over to https://btc.exitpay.org/ and clicking on "Create your account."

[INSERT SCREENSHOT]

Enter your email, password, and confirm your password, and then click on "Create account." After that, an email will be sent to you to confirm your BTCPay account. Click on the link in the email to confirm your account.

[INSERT SCREENSHOT]

Once your email has been confirmed, sign in to your newly created account. You'll be redirected to create a new store.

[INSERT SCREENSHOT]

Give your store a name (e.g., Personal Bitcoin Tip Card), select BTC as the default currency, choose your preferred price source, and click on "Create."

You'll then be redirected to your BTCPay dashboard.

[INSERT SCREENSHOT]

From here, you need to set up a wallet.

[INSERT SCREENSHOT]

Click on "Connect an existing wallet," and select the "Add Extended Pub Key" option.

If your wallet(any external wallet that you've been using) displays your wallet XPUB, you can easily paste it in here. In my case, I'm using BlueWallet, which has an option of "Show Wallet XPUB" that you can click to copy and paste it here.

With this best practice, BTCPay will work only as a watch-only wallet, meaning that it will generate addresses for you to receive Bitcoin, but it will never be able to spend your Bitcoins from here.

After the wallet has been successfully set up, you'll be redirected here:

[INSERT SCREENSHOT]

Next, go to "Settings" and click on "Access Token."

[INSERT SCREENSHOT]

Click the "Generate" button, and a token will be created for you. Keep this token with you by creating a new file locally and copying and pasting the token there.

Now, generate the "Store ID" from "Settings," and keep it with you.

[INSERT SCREENSHOT]

That's all for the BTCPay API generation process. In the next section, we'll look at how you can generate the commit secret for GitHub, which will help you to automate the process of deployment.

To get your GitHub personal token, head over to your GitHub settings:

[INSERT SCREENSHOT]

Then click on "Developer Settings."

[INSERT SCREENSHOT]

Next, go to the "Personal Access Token (classic)" option and click on "Generate new token."

[INSERT SCREENSHOT]

It will redirect you to add some general info about this Personal Access Token.

[INSERT SCREENSHOT]

Give it a note whatever you want (e.g., "GitHub actions for commit"), and checkmark the "repo:status" and "public_repo" from the repo scope. Then, generate this token and keep it with you. Remember that you now have the BTCPayToken, BTCPayStoreId, and GitHub personal access token with you. Don't forget about that!

Next, head over to the repository of the "Personal Bitcoin Tip Card" project and fork it. Change the project name to something like "yourgithubusername.github.io" (e.g., aniketambore.github.io). From there, click on the "Settings" of the repository.

From the settings menu, click on "Actions," which is under "Security." It will display the "Actions secrets and variables" section. From there, you need to click on "New repository secret" and create five different secrets, including:

1. COMMIT_SECRET: paste your GitHub commit secret
2. BTC_PAY_USERNAME: paste your BTCPay username
3. BTC_PAY_PASSWORD: paste your BTCPay password
4. BTC_PAY_TOKEN: paste your BTCPay token
5. BTC_PAY_URL: https://btc.exitpay.org/api/v1/stores/{your-btc-pay-store-id-paste-here}/invoices

Remember to paste your BTCPay store id above(in BTC_PAY_URL value) removing the braces.

Do note that the name of the secrets has to be similar to all the five variables because the workflow will call these secrets at the time of deployment of your website.

After the secrets have been set up, it's time to edit the cicd.yml file, which is located in the .github/workflow/ folder. From there, you only need to change the "git remote add origin url" as something like:

git remote add origin https://${{ secrets.COMMIT_SECRET }}@github.com/{your-github-username}/{your-github-username}.github.io.git

Modify with your GitHub username, removing the braces.

After that change, head over to the "develop" branch. In the "develop" branch, you need to merge the commit of the "main" branch to this. Just click on the "1 commit behind" and then merge the "main" branch to the "develop" branch. After the "main" branch is merged to the "develop" branch, the workflow will trigger and start the deployment process.

If you've followed all the steps correctly up until this point, the deployment process will run seamlessly. The deployment process will create a new branch named "gh-pages." Next, head over to "Settings" on the repository (not your GitHub user settings). Click on "Pages" and select the "gh-pages" branch as root. Click on "Save," and your Personal Bitcoin Tip Card is successfully deployed!

You will receive information about your tip card, including the name, message, and invoice status. You can view this information in a screenshot.

To customize your tip card, you will need to change the default values in the identity.json file, which can be found in the "main" branch. You can see a screenshot of the file.

Make sure to update the default values with your own values before committing the changes to the "main" branch. Once you have made the necessary changes, switch to the "develop" branch and merge the "main" branch into it. This will trigger the deployment process and update your changes to the tip card. You can see a screenshot of the deployment process.

That's it for the setup process of your Personal Bitcoin Tip Card. If you have any questions about the project or need further assistance, please feel free to leave a comment below.

Thank you for taking the time to read this guide, and happy tipping!