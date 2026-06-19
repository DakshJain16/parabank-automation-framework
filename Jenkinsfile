pipeline {
    agent any

    ```
    options {
        timestamps()
        skipDefaultCheckout(false)
        disableConcurrentBuilds()
    }

    environment {
        VENV_DIR       = "venv"
        OUTPUT_DIR     = "output"
        REQ_FILE       = "requirements.txt"
        TESTS_DIR      = "tests"
        ALLURE_RESULTS = "output/allure-results"
        ALLURE_REPORT  = "output/allure-report"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "==== Checking out source code from SCM ===="
                checkout scm
                sh 'echo "Checkout complete. Workspace: $WORKSPACE"'
            }
        }

        stage('Validate Project Structure') {
            steps {
                echo "==== Validating project structure ===="
                sh '''
                    if [ ! -f "$REQ_FILE" ]; then
                        echo "ERROR: requirements.txt not found."
                        exit 1
                    fi

                    if [ ! -d "$TESTS_DIR" ]; then
                        echo "ERROR: tests directory not found."
                        exit 1
                    fi

                    echo "Validation passed."
                '''
            }
        }

        stage('Setup Python Environment') {
            steps {
                echo "==== Setting up Python virtual environment ===="
                sh '''
                    VENV_PY="$WORKSPACE/$VENV_DIR/bin/python"

                    if [ -d "$VENV_DIR" ]; then
                        echo "Virtual environment found. Verifying..."
                        if [ ! -f "$VENV_PY" ]; then
                            echo "Virtual environment corrupted. Recreating..."
                            rm -rf "$VENV_DIR"
                        fi
                    fi

                    if [ ! -d "$VENV_DIR" ]; then
                        echo "Creating virtual environment..."
                        python3 -m venv "$VENV_DIR"

                        if [ $? -ne 0 ]; then
                            echo "ERROR: Failed to create virtual environment."
                            exit 1
                        fi
                    else
                        echo "Reusing existing virtual environment."
                    fi

                    source "$VENV_DIR/bin/activate"

                    python -m pip install --upgrade pip

                    if [ $? -ne 0 ]; then
                        echo "ERROR: Failed to upgrade pip."
                        exit 1
                    fi
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "==== Installing dependencies ===="
                sh '''
                    source "$VENV_DIR/bin/activate"

                    pip install -r "$REQ_FILE"

                    if [ $? -ne 0 ]; then
                        echo "ERROR: Dependency installation failed."
                        exit 1
                    fi

                    python -m robot --version

                    python -c "import robot; print('Robot Framework module OK:', robot.__file__)"

                    if [ $? -ne 0 ]; then
                        echo "ERROR: Robot Framework verification failed."
                        exit 1
                    fi
                '''
            }
        }

        stage('Execute Robot Tests') {
        steps {
        echo "==== Executing Robot Framework tests ===="

        ```
            script {
                int robotExitCode = sh(
                    script: '''
                        source "$VENV_DIR/bin/activate"

                        rm -rf "$OUTPUT_DIR"
                        mkdir -p "$OUTPUT_DIR"
                        mkdir -p "$ALLURE_RESULTS"

                        python -m robot \
                            --outputdir "$OUTPUT_DIR" \
                            --listener allure_robotframework:$ALLURE_RESULTS \
                            "$TESTS_DIR"

                        exit $?
                    ''',
                    returnStatus: true
                )

                echo "Robot execution completed with exit code ${robotExitCode}"

                if (robotExitCode > 0 && robotExitCode < 250) {
                    currentBuild.result = 'UNSTABLE'
                    echo "Some Robot Framework test cases failed."
                }
                else if (robotExitCode >= 250) {
                    error("Robot Framework execution error. Exit code: ${robotExitCode}")
                }
            }
        }
        ```
        }


        stage('Publish Reports') {
            steps {
                echo "==== Publishing Robot Framework reports ===="
                script {
                    def outputXml = "${env.OUTPUT_DIR}/output.xml"

                    if (fileExists(outputXml)) {
                        try {
                            step([
                                $class: 'RobotPublisher',
                                outputPath: "${env.OUTPUT_DIR}",
                                outputFileName: 'output.xml',
                                reportFileName: 'report.html',
                                logFileName: 'log.html',
                                disableArchiveOutput: false,
                                passThreshold: 0,
                                unstableThreshold: 0,
                                otherFiles: ''
                            ])

                            echo "Robot Framework reports published."
                        } catch (Exception err) {
                            echo "Robot Plugin unavailable. Using artifact archive only."
                        }
                    } else {
                        echo "output.xml not found."
                    }
                }
            }
        }

        stage('Generate Allure Report') {
            steps {
                echo "==== Generating Allure report ===="
                sh '''
                    if [ ! -d "$ALLURE_RESULTS" ]; then
                        echo "No Allure results found."
                        exit 0
                    fi

                    if ! command -v allure >/dev/null 2>&1; then
                        echo "Allure command not installed."
                        exit 0
                    fi

                    allure generate "$ALLURE_RESULTS" \
                        -o "$ALLURE_REPORT" \
                        --clean \
                        --single-file || true
                '''
            }
        }

        stage('Generate Robot Metrics') {
            steps {
                echo "==== Generating Robot Metrics ===="
                sh '''
                    source "$VENV_DIR/bin/activate"

                    if [ ! -f "$OUTPUT_DIR/output.xml" ]; then
                        echo "output.xml not found. Skipping metrics."
                        exit 0
                    fi

                    robotmetrics -I "$OUTPUT_DIR" || true
                '''
            }
        }

        stage('Archive Artifacts') {
            steps {
                echo "==== Archiving reports ===="
                script {
                    if (fileExists("${env.OUTPUT_DIR}")) {
                        archiveArtifacts(
                            artifacts: "${env.OUTPUT_DIR}/**/*.*",
                            allowEmptyArchive: true,
                            fingerprint: false
                        )

                        echo "Artifacts archived."
                    } else {
                        echo "Output directory not found."
                    }
                }
            }
        }
    }

    post {
        always {
            echo "==== Post-build actions ===="

            script {
                if (fileExists("${env.OUTPUT_DIR}")) {
                    archiveArtifacts(
                        artifacts: "${env.OUTPUT_DIR}/**/*.*",
                        allowEmptyArchive: true,
                        fingerprint: false
                    )
                }
            }

            sh '''
                echo "Cleaning __pycache__ directories..."

                find "$WORKSPACE" \
                    -type d \
                    -name "__pycache__" \
                    -exec rm -rf {} +

                echo "Cleanup complete."
            '''
        }

        success {
            echo "==== Build completed successfully ===="
        }

        unstable {
            echo "==== Build UNSTABLE - Some tests failed ===="
        }

        failure {
            echo "==== Build FAILED ===="
        }
    }
    ```
}
