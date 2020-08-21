package uniolunisaar.adam.logic.ui.cl.modules;

import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.Pnwt2Dot;
import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.Pnwt2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.benchmarks.Benchmark;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.benchmarks.BenchmarkSynt2017;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.benchmarks.BenchmarkTacas2018;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.Pg2Dot;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.Pg2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.Pg2Tikz;
import uniolunisaar.adam.logic.ui.cl.modules.exporter.Exporter;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.generators.RedundantFlowNetworkModule;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.generators.RemoveNodeUpdateNetworkModule;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.generators.SmartFactoryModule;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.generators.TopologieZooModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.ConcurrentMachinesModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.ContainerTerminalModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.DocumentWorkflowModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.EmergencyBreakdownModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.JopProcessingModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.PhilosophersModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.SecuritySystemModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.SelfReconfiguringRobotsModule;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.generators.WatchdogModule;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.checker.PetrinetModelchecker;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.solver.ExWinStrat;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.solver.WinStrat;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.benchmarks.BenchmarkCAV2019;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.benchmarks.BenchmarkHL2019;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.benchmarks.BenchmarkRvG2019;

/**
 *
 * @author Manuel Gieseking
 */
public class ModulesAll extends Modules {

    private static final AbstractModule[] modules = {
        // Converter
        new Pg2Dot(),
        new Pnwt2Dot(),
        new Pg2Pdf(),
        new Pnwt2Pdf(),
        new Pg2Tikz(),
        // Solver
        new ExWinStrat(),
        new WinStrat(),
        // Modelchecker
        new PetrinetModelchecker(),
        // Benchmark
        new Benchmark(),
        new BenchmarkSynt2017(),
        new BenchmarkTacas2018(),
        new BenchmarkCAV2019(),
        new BenchmarkHL2019(),
        new BenchmarkRvG2019(),
        // Exporter
        new Exporter(),
        // Generators Petri Games
        new PhilosophersModule(),
        new DocumentWorkflowModule(),
        new JopProcessingModule(),
        new SelfReconfiguringRobotsModule(),
        new ConcurrentMachinesModule(),
        new WatchdogModule(),
        new SecuritySystemModule(),
        new ContainerTerminalModule(),
        new EmergencyBreakdownModule(),
        // Generators Model Checking
        new RemoveNodeUpdateNetworkModule(),
        new RedundantFlowNetworkModule(),
        new TopologieZooModule(),
        new SmartFactoryModule()
    };

    @Override
    public AbstractModule[] getModules() {
        return modules;
    }

}
