# Cloudant

Please use https://github.ibm.com/Bluemix-Docs/Cloudant/ for contributions.
Pushes to https://github.com/IBM-Bluemix-Docs/Cloudant are only allowed
by members of documentation team.

# Build & CI

## Jenkins


Jenkins is used to publish docs to staging and to production.
The setup is managed by Bluemix Documentation team.

https://wcp-ace-docs-jenkins.swg-devops.com/job/Docs-build/job/Docs-build-Cloudant/

## Travis

Travis is used to keep github.com and github.ibm.com repositories in sync.
The setup is managed by Cloudant infra team.

https://travis.ibm.com/Bluemix-Docs

# Requesting a documentation change

Here's what you need to do to request new documentation or changes to the documentation.

**Before you begin**: Request access to the Staging repository by creating a [fogbugz ticket](https://cloudant.fogbugz.com/f/cases/new?command=new&ixCategory=11&ixProject=28&ixArea=88&ixPersonAssignedTo=245&sTitle=Please%20grant%20write%20access%20to%20the%20Documentation%20repository:%20%3Cyour%20GHE%20account%3E). 

To request a documentation change, follow these steps:

1. Create a Fogbugz case for the documentation change.

    a. Assign this to the Documentation project.
    b. Assign the case to yourself, and notify Lora.
    c. Add a note to the case that you intend to make changes yourself. 
    d. (New page) If you are requesting a new page, make a note of that in the case, and Lora will create it, and send you a PR. 

2. Make the change via the GHE UI:

    a. From a browser, go to the Bluemix-Docs/Cloudant repo, https://github.ibm.com/Bluemix-Docs/Cloudant.
    b. Open the *master* branch.
    c. Open the file you want to change, or click **Create new file**.
    d. Click the pencil icon to edit.
    e. Add your changes.
    f. When you're finished, select **Create a new branch for this commit and start a pull request**.
    g. Name the branch *fb<your case number>-a good description*.
    h. Click **Propose file change** or **Propose new file**.

3. Or, via a repo clone (advanced):

    a. Clone [staging repository on GHE](https://github.ibm.com/Bluemix-Docs/Cloudant) repository.

      ```
      git clone git@github.ibm.com:Bluemix-Docs/Cloudant.git
      ```
    b. Branch from *master* with a new branch named *fb(your case number)-a good description*.
      ```
      git checkout -b fbXXXXX
      ```
    c. Make your changes.
    d. Push the feature branch to [Staging repository on GHE](https://github.ibm.com/Bluemix-Docs/Cloudant).
      ```
      git push origin fbXXXXX
      ```

4. Open a pull request (PR) with a descriptive title and comment.
(You do this from your browser on the Bluemix-Docs/Cloudant repo, https://github.ibm.com/Bluemix-Docs/Cloudant.)

	a. Click **Create New pull request**.
	b. Choose *base: master*.
	c. Choose *compare: your-patch*.
	d. Click **Create pull request**. Add link to the PR to the Fogbugz case that you created.

5. Documentation team member reviews the changes to check grammar, IBM style, accessibility, and translation guidelines.

6. Documentation team member pushes to staging for review.

7. Developer reviews content on staging server and adds changes to the PR, or if satisfied, moves to step 10.

8. Repeat process until document is satisfactory by using the UI, or
	from the command line, use the following commands:
    ```
    git checkout fbXXXXX
    git add -p
    git commit -m "Fix typo."
    git push origin fbXXXXX
    ```

9. **(Optional)** Author of the PR squashes commits on the branch.
    ```
    git checkout fbXXXXX
    git pull --rebase origin fbXXXXX
    git rebase -i master
    git push -f origin fbXXXXX
    ```

10. When document is satisfactory. both author and doc team member approve the PR.

    a. Author approves the PR by adding +1 to the commit message.

        1. Open your PR.
        2. Leave a comment, `+1`. 
        3. Click **Comment**.

    b. Documentation team member adds a +1 to the commit message.

11. Documentation team member merges PR and pushes to production.
