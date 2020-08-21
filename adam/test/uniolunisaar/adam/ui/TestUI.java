package uniolunisaar.adam.ui;

import uniolunisaar.adam.logic.ui.cl.AdamUI;
import uniolunisaar.adam.main.ui.cl.AdamComplete;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import org.apache.commons.cli.BasicParser;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.ParseException;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import uniolunisaar.adam.tools.Logger;
import uniolunisaar.adam.logic.ui.cl.modules.AbstractModule;
import uniolunisaar.adam.logic.ui.cl.modules.ModulesAll;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.solver.WinStrat;

/**
 *
 * @author Manuel Gieseking
 */
@Test
public class TestUI {

    private static final String examplesFolder = System.getProperty("examplesfolder") + "/";

    private final ByteArrayOutputStream baos = new ByteArrayOutputStream();
    PrintStream ps;
    PrintStream old;

    @BeforeMethod
    public void beforeMethode() {
        Logger.getInstance().setVerbose(false);
        old = System.out;
        // clear the old stream
        baos.reset();
        ps = new PrintStream(baos);
        Logger.getInstance().setErrorStream(ps);
        // Tell Java to use your special stream
        System.setOut(ps);
    }

    @AfterMethod
    public void afterMethode() {
        System.setOut(old);
    }

    private String getUIOutput(String[] args) {
        AdamComplete.main(args);
        ps.flush();
        return baos.toString();
    }

    @Test
    public void testEmptyArguments() {
        String[] args = {};

        // test empty argument        
        String helpProg = getUIOutput(args);

        // should lead to the printPossibleModulesDialog
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        PrintWriter bufferStream = new PrintWriter(buffer);
        new ModulesAll().printPossibleModules(bufferStream);
        bufferStream.flush();
        String helpSys = buffer.toString();

        //Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @Test
    public void testNotExistingModule() {
        String[] args = {"asdf"};

        // test wrong module
        String helpProg = getUIOutput(args);

        // should lead to the printPossibleModulesDialog with the prepended 
        // error msg
        String helpSys = "[ERROR] '" + args[0] + "' is not a suitable module.\n";
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        PrintWriter bufferStream = new PrintWriter(buffer);
        new ModulesAll().printPossibleModules(bufferStream);
        bufferStream.flush();
        helpSys += buffer.toString();

        // Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @DataProvider(name = "modules")
    private static Object[][] getModules() {
        AbstractModule[] modules = new ModulesAll().getModules();
        Object[][] out = new Object[modules.length][1];
        for (int i = 0; i < out.length; i++) {
            out[i][0] = modules[i];
        }
        return out;
    }

    @Test(dataProvider = "modules")
    public void testModuleWithoutParameter(AbstractModule module) {
        String[] args = {module.getName()};

        // test without paras
        String helpProg = getUIOutput(args);

        // should lead to the help dialog of the module
        String helpSys = module.getHelp();

        // Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @Test(dataProvider = "modules")
    public void testModuleWithWrongParameters(AbstractModule module) {
        String[] args = {module.getName(), "asdf"};

        // test wrong parameter
        String helpProg = getUIOutput(args);

        // should lead to the help dialog of the module
        // create the command line parser with an error message
        String helpSys = "";
        CommandLineParser parser = new BasicParser();
        args = Arrays.copyOfRange(args, 1, args.length);
        try {
            CommandLine line = parser.parse(module.getOptions(), args);
            module.execute(line);
            Assert.fail("This call of the module '" + module.getName() + " with args " + args[1] + "' should have been failed.");
        } catch (ParseException ex) {
            helpSys = "[ERROR] Invalid use of '" + module.getName() + "': " + ex.getMessage() + "\n";
            helpSys += module.getHelp();
        } catch (Exception exp) {
            Assert.fail("Exception " + exp.getMessage() + " should not been thrown!");
        }
        module.getHelp();

        // Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @Test(dataProvider = "modules")
    public void testModuleMissingRequiredOptions(AbstractModule module) {
        String[] args = {module.getName(), "asdf"};

        // test wrong parameter
        String helpProg = getUIOutput(args);

        // Should lead to a help Dialog with error msg containing the missing
        // required options
        List<String> opts = module.getOptions().getRequiredOptions();
        String s = (opts.size() != 1) ? "s" : ""; // todo: what happens when there modules exists without any required option?
        String error = "[ERROR] Invalid use of '" + module.getName() + "': ";
        error += "Missing required option" + s + ": ";
        for (int i = 0; i < opts.size() - 1; i++) {
            error += opts.get(i) + ", ";
        }

        Object lastOpt = opts.get(opts.size() - 1); // necessary for option groups        
        error += lastOpt.toString() + "\n";
        String helpSys = error + module.getHelp();

        // Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @Test
    public void testExWinStrat() {
        // test could not find file
        String[] args = {"ex_win_strat", "-i", "notAGoodPath", "-sol", "bdd"};
        String helpProg = getUIOutput(args);
        String helpSys = "[ERROR] File 'notAGoodPath' does not exist\n";
        //Check
        Assert.assertEquals(helpProg, helpSys);
    }

    @Test
    public void testWinStratBDD() {
        String burglar = examplesFolder + "safety/burglar/burglar.apt";
        AdamUI.debug = true;
        System.setOut(old);
        // test wrong parameter
        String[] args = {"win_strat", "-sol", "bdd=-ggs,-npgs", "-i", burglar};
        String helpProg = getUIOutput(args);
        WinStrat module = new WinStrat();
    }

}
