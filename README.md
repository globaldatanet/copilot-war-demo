# Copilot War Demo

The companion-repo for a future AWS partner blog post.


## Initial Setup

In these first steps we will setup a demo web service, along with scheduled jobs to start and
shutdown these services in the morning and evening. This is done for cost saving purposes.

1. Fork the repo and check it out locally.
   - This is needed for the pipeline we're going to deploy further down the road. You will need
     your own repo on github so copilot can create the pipeline for it.
2. Setup a demo webservice

    ```bash
    copilot init
    ```
    - Application name: blogpost-demo
    - Workload type: Load Balanced Web Service
    - Service name: nyan
    - Dockerfile: ./Dockerfile
    - Answer "yes" if you're asked if you want a test environment. This will be the one we're
      using for this demo.


## Deploying Shutdown Scheduling Jobs for Cost Saving

1. Deploy the copilot job which stop the containers in the evening

    1. Initialization
       ```bash
       copilot job init --name stop-containers
       ```
       It does not matter which details you configure, they will be dismissed and instead read from the
       manifest file.

    2. Deployment
       ```bash
       copilot job deploy --name stop-containers --env test
       ```

2. Deploy the copilot job which starts the containers in the morning

    1. Initialization
       ```bash
       copilot job init --name start-containers
       ```
       It does not matter which details you configure, they will be dismissed and instead read from the
       manifest file.

    2. Deployment
       ```bash
       copilot job deploy --name start-containers --env test
       ```

## Deploying a Codepipeline with Container Security Checks

To add a security check using `hadolint` we simply added the following two steps to the default
`buildspec.yaml`:
```bash
docker pull ghcr.io/hadolint/hadolint
docker run --rm -i ghcr.io/hadolint/hadolint < Dockerfile
```

1. Initialize the pipeline
   ```bash
   copilot pipeline init
   ```

2. Deploy the pipeline
   ```bash
   copilot pipeline update
   ```
   - Activate the github connection when asked
   - The pipeline will now already be triggered

3. Verify that the security check has indeed been executed.
   - Search for "Run your tests" to find the testing section.

## Cleanup

Finally, it's time to clean up the created resources.

```bash
copilot job delete
copilot job delete
copilot app delete
```
