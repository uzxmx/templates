// vi: ft=groovy
allprojects {
    def configureMirrors = {
        // Visit https://maven.aliyun.com/mvn/guide to get supported maven mirrors.

        // `public` Contains libraries from both maven central and jcenter.
        it.maven { url "https://maven.aliyun.com/repository/public" }

        it.maven { url "https://maven.aliyun.com/repository/google" }
        it.maven { url "https://maven.aliyun.com/repository/gradle-plugin" }
        it.maven { url "https://maven.aliyun.com/repository/spring" }
        it.maven { url "https://maven.aliyun.com/repository/spring-plugin" }
        it.maven { url "https://maven.aliyun.com/repository/grails-core" }
        it.maven { url "https://maven.aliyun.com/repository/apache-snapshots" }
    }

    // For more information, please visit
    // https://docs.gradle.org/current/userguide/tutorial_using_tasks.html#sec:build_script_external_dependencies
    buildscript {
        repositories {
            configureMirrors(it)
        }
    }

    // For more information, please visit
    // https://docs.gradle.org/current/userguide/declaring_repositories.html
    repositories {
        configureMirrors(it)
    }
}
