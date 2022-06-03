Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5E53C985
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbiFCLqw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiFCLqv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 07:46:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D6DF2;
        Fri,  3 Jun 2022 04:46:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6308468AFE; Fri,  3 Jun 2022 13:46:45 +0200 (CEST)
Date:   Fri, 3 Jun 2022 13:46:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 0/8] Use block pr_ops in LIO
Message-ID: <20220603114645.GA14309@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065536.5641-1-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From a highlevel POV this looks good.  I'll do a more detail review in
the next days once I find a little time.  Any chance you could also
wire up the new ops for nvme so that we know the abtractions work right
even for exporting nvme as SCSI?  No need to wire up nvmet for now, but
that would be the logical next step.
