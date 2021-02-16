"$(sh -c "[ -z '$GEN_JAVA_PACKAGE' ] || echo 'package $GEN_JAVA_PACKAGE;\n\n'")"import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
@Transactional
public class ${GEN_JAVA_NAME} {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testFoo() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get(\"/foo\")).
            andExpect(MockMvcResultMatchers.status().isOk()).andReturn();
        assertEquals(\"SUCCESS\", result.getResponse().getContentAsString());
    }
}
