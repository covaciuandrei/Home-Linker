allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.library") {
        val androidExt = extensions.findByName("android") ?: return@withId
        val getNamespace =
            androidExt.javaClass.methods.find {
                it.name == "getNamespace" && it.parameterCount == 0
            }
        val setNamespace =
            androidExt.javaClass.methods.find {
                it.name == "setNamespace" &&
                    it.parameterCount == 1 &&
                    it.parameterTypes.firstOrNull() == String::class.java
            }

        if (getNamespace != null && setNamespace != null) {
            val currentNamespace = getNamespace.invoke(androidExt) as? String
            if (currentNamespace.isNullOrBlank()) {
                val groupValue = project.group.toString()
                val fallbackNamespace =
                    if (groupValue.isNotBlank() && groupValue != "unspecified") {
                        groupValue
                    } else {
                        "com.generated.${project.name.replace("-", "_")}"
                    }

                setNamespace.invoke(androidExt, fallbackNamespace)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
