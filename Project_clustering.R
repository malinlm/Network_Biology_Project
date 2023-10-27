library(RCy3)
library(igraph)
library(clusterProfiler)
library(org.Hs.eg.db)

cytoscapePing()
networkSuid = getNetworkSuid()

#installApp("clustermaker2") # run if needed
commandsHelp("help cluster")

clustermaker <- paste("cluster glay createGroups=FALSE network=SUID:",networkSuid, sep="")
res <- commandsGET(clustermaker)
num <- as.numeric(gsub("Clusters: ", "", res[1]))

# for each cluster
for(i in 1:num) {
  setCurrentNetwork(network=networkSuid)
  clearSelection(network=networkSuid)
  current_cluster <- i
  selectednodes <- selectNodes(network=networkSuid, current_cluster, by.col="__glayCluster")
  if(length(selectednodes$nodes) > 30) {
    # Subnetwork creation
    subnetwork_suid <- createSubnetwork(nodes="selected", network=networkSuid)
    #renameNetwork(paste("Glay_Cluster3",i,"_Subnetwork", sep=""), network=as.numeric(subnetwork_suid))
    layoutNetwork()
  }
}