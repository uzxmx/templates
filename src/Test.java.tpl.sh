"$(sh -c "[ -z '$GEN_JAVA_PACKAGE' ] || echo 'package $GEN_JAVA_PACKAGE;\n\n'")"import org.junit.Test;

public class ${GEN_JAVA_NAME} {

    @Test
    public void testFoo() {
        System.out.println("foo");
    }
}
