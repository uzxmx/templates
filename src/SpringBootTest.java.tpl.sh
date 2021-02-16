"$(sh -c "[ -z '$GEN_JAVA_PACKAGE' ] || echo 'package $GEN_JAVA_PACKAGE;\n\n'")"import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class ${GEN_JAVA_NAME} {

    @Test
    public void testFoo() {
      System.out.println(\"foo\");
    }
}
