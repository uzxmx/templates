"$(sh -c "[ -z '$GEN_JAVA_PACKAGE' ] || echo 'package $GEN_JAVA_PACKAGE;\n\n'")""$(sh -c "[ -z '$GEN_JAVA_IMPORTS' ] || echo '$GEN_JAVA_IMPORTS\n\n'")"

public interface ${GEN_JAVA_NAME} extends ${GEN_JAVA_EXTENDS} {
}
