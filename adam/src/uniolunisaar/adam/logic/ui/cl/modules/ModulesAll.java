package uniolunisaar.adam.logic.ui.cl.modules;

import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.Pnwt2Dot;
import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.Pnwt2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.converter.petrinet.Pn2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.converter.petrinet.Pn2Unfolding;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.synthesis.Benchmark;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.synthesis.BenchmarkSynt2017;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.modelchecking.BenchmarkTacas2018;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.pgwt.Pg2Dot;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.pgwt.Pg2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.converter.synthesis.pgwt.Pg2Tikz;
import uniolunisaar.adam.logic.ui.cl.modules.exporter.Exporter;
import uniolunisaar.adam.logic.ui.cl.modules.generators.modelchecking.RedundantFlowNetworkModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.modelchecking.RemoveNodeUpdateNetworkModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.modelchecking.SmartFactoryModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.modelchecking.TopologieZooModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.ConcurrentMachinesModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.ContainerTerminalModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.DocumentWorkflowModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.EmergencyBreakdownModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.JopProcessingModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.PhilosophersModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.SecuritySystemModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.SelfReconfiguringRobotsModule;
import uniolunisaar.adam.logic.ui.cl.modules.generators.synthesis.WatchdogModule;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.checker.PetrinetModelchecker;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.solver.ExWinStrat;
import uniolunisaar.adam.logic.ui.cl.modules.synthesis.solver.WinStrat;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.modelchecking.BenchmarkCAV2019;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.synthesis.BenchmarkHL2019;
import uniolunisaar.adam.logic.ui.cl.modules.benchmarks.synthesis.BenchmarkRvG2019;
import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.SDN2Dot;
import uniolunisaar.adam.logic.ui.cl.modules.converter.modelchecking.SDN2Pdf;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.checker.PetriNetWithTransitsModelchecker;
import uniolunisaar.adam.logic.ui.cl.modules.modelchecking.checker.SDNModelchecker;

/**
 *
 * @author Manuel Gieseking
 */
public class ModulesAll extends Modules {

    private static final AbstractModule[] modules = {
        // Converter
        new Pn2Pdf(),
        new Pn2Unfolding(),
        new Pnwt2Dot(),
        new Pg2Dot(),
        new SDN2Dot(),
        new Pnwt2Pdf(),
        new Pg2Pdf(),
        new SDN2Pdf(),
        new Pg2Tikz(),
        // Solver
        new ExWinStrat(),
        new WinStrat(),
        // Modelchecker
        new PetrinetModelchecker(),
        new PetriNetWithTransitsModelchecker(),
        new SDNModelchecker(),
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
