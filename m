Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123423128B
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgG1T3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 15:29:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58780 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgG1T3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:29:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 474CCBF6BD;
        Tue, 28 Jul 2020 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1595963993;
        bh=kdeteFBDNrirkRUPBxtzN/aiA72sWxQuV9uk0LqV8Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rlz48T3ZamYZ/3xlk5S19E/Rn5B54Y9xBOtf3yCx07SsCpot6TENLPtkySJGQQG4K
         rwMGxNoWekH1gaqDgYkNcP7Rx4JMzeHauhOBklNkd3JpLNVwxkPgwEWhT0zLaZvLnN
         KB6SeNj36HDmxJ/8E67ADKJX/+2vyr0uxfGz4mp7yVv2KpLBZ/IhinvAllhekOVjs7
         KI74uQaQebj+lKMi+pwpaO7+57I9B8NaoOxihH7ZKG0P7ZULlFindbLzC2je60U0DQ
         FQ3tQXBYjDkD28csGszO2dakEwKHfOsq7xiuqY3tGNxV/OfN+nfUDt+v7xaxUA0Eo9
         MZ4qzZrIpIH1A==
Date:   Tue, 28 Jul 2020 21:19:51 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/5] zbd/002: Check validity of zone capacity
Message-ID: <20200728191951.GB103177@apples.localdomain>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-3-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28 19:14, Shin'ichiro Kawasaki wrote:
> Linux kernel 5.9 zone descriptor interface added the new zone capacity
> field defining the range of sectors usable within a zone. Add a check to
> ensure that the zone capacity is smaller than or equal to the zone size.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
