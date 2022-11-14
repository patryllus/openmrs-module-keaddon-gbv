package org.openmrs.module.keaddonexample.metadata;

import org.openmrs.module.metadatadeploy.bundle.AbstractMetadataBundle;
import org.openmrs.module.metadatadeploy.bundle.Requires;
import org.springframework.stereotype.Component;

import static org.openmrs.module.metadatadeploy.bundle.CoreConstructors.*;

/**
 * Implementation of access control to the app.
 */
@Component
@Requires(org.openmrs.module.kenyaemr.metadata.SecurityMetadata.class)
public class GbvSecurityMetadata extends AbstractMetadataBundle {

    public static class _Privilege {

        public static final String APP_GBV_ADMIN = "App: gbv.app.home";
    }

    public static final class _Role {

        public static final String APPLICATION_GBV_ADMIN = "gbv app administration";
    }

    /**
     * @see AbstractMetadataBundle#install()
     */
    @Override
    public void install() {

        install(privilege(_Privilege.APP_GBV_ADMIN, "Able to assess gbv for a patient"));
        install(role(_Role.APPLICATION_GBV_ADMIN, "Can access gbv app",
                idSet(org.openmrs.module.kenyaemr.metadata.SecurityMetadata._Role.API_PRIVILEGES_VIEW_AND_EDIT),
                idSet(_Privilege.APP_GBV_ADMIN)));
    }
}
