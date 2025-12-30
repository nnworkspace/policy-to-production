/*
 * artefact_type: code
 * role: build-definition
 * owner: engineering-platform
 * status: operative
 *
 * DISCLAIMER: The code in this folder is **illustrative and educational**.
 * It does not represent official implementations, production-ready components,
 * or endorsed technical approaches for the Digital Euro or any other real-world system.
 */

plugins {
    `java-library` // 'java-library' is for shared components, 'java' is for apps
}

group = "eu.digitaleuro.governance"
version = "0.1.0-SNAPSHOT"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

repositories {
    mavenCentral()
}

dependencies {
    // No external dependencies for this pure governance library
    // If we needed testing, we would add:
    // testImplementation("org.junit.jupiter:junit-jupiter:5.10.0")
}

tasks.withType<JavaCompile> {
    options.encoding = "UTF-8"
}
