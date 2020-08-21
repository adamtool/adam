package uniolunisaar.adam.logic.ui.cl.modules.exporter;

import uniolunisaar.adam.logic.ui.cl.modules.Modules;
import uniolunisaar.adam.logic.ui.cl.modules.ModulesAll;

/**
 *
 * @author Manuel Gieseking
 */
public class Exporter extends AbstractExporter {

    @Override
    protected Modules getModules() {
        return new ModulesAll();
    }

}
