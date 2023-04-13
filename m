Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA42E6E0636
	for <lists+linux-block@lfdr.de>; Thu, 13 Apr 2023 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMFAO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Apr 2023 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMFAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 01:00:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575DA5BA2;
        Wed, 12 Apr 2023 22:00:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C03486732D; Thu, 13 Apr 2023 07:00:09 +0200 (CEST)
Date:   Thu, 13 Apr 2023 07:00:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com
Subject: Re: [PATCH 2/4] blkcg: Restructure blkg_conf_prep() and friends
Message-ID: <20230413050009.GB14083@lst.de>
References: <20230413000649.115785-1-tj@kernel.org> <20230413000649.115785-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413000649.115785-3-tj@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
