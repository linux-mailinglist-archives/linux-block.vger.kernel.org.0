Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66F4DA885
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 03:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiCPCmc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Mar 2022 22:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiCPCmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 22:42:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C34532E5
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 19:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbEB0roRVvZH1WT7PHB8MLjegnsgpeq5p11PLtgy6qI=; b=U39MVrxBCXMc3vIhbWc1ANPtK4
        BVEnxnXC6i6i0qk/raAgADoWu+r4z2Ir7farV+TU/c4hUODaVpjRfUIO4FqlKMUwjcZfG3OOLuth8
        /J3gkJ+/6tkLj0wcv8CnyF4C7/X8Xix/35Rkzy5eylDTGS5s8DP2io9h92ibLMD4aoaeyaBeqMHrP
        feZc9FyRKrkLBw4svRTCo7dcphvQ1dCw1AYxp+07bSe0eppePahceOEpwpJq/gSzOxm5qDlIcNpSY
        BXX8npRLLHs8K2Zh9XisHGlso5bn/r04F2wptZQ/jtccvMhDPUGnO2Or6aXirOsLyHI58szIeZFSg
        cAD1qZIQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUJax-00BEVM-Mg; Wed, 16 Mar 2022 02:41:03 +0000
Date:   Tue, 15 Mar 2022 19:41:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjFOP3edr3sSm1SE@bombadil.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 10:27:32PM -0400, Martin K. Petersen wrote:
> Simplicity and long term maintainability of the kernel should always
> take precedence as far as I'm concerned.

No one is arguing against that. It is not even clear what all the changes are.
So to argue that the sky will fall seems a bit too early without seeing
patches, don't you think?

  Luis
